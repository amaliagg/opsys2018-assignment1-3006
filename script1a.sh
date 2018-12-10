#!/bin/bash
touch temp
temp_file="./temp"

while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ $line = '#'* ]]
    then
        continue
    fi
    
    filename=${line////$'_'}
    if [[ -f "$filename" ]]
    then
        
        curl -s $line -o "$temp_file"
        if ! cmp -s "$filename" "$temp_file"; then
            echo "$line"
        
        fi
        >temp
    else
        touch $filename
        echo "$line INIT"
        curl -s $line -o "$filename"
    fi
done < "$1"  
