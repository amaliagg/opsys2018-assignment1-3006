function check(){
	line=$1
	if [[ $line = '#'* ]]
    	then
        	return
    	fi
       	filename=${line////$'_'}
    	if [[ -f "$filename" ]]
    	then
        
		curl -s $line -o "$temp_file"
		if ! cmp -s "$filename" "$temp_file"; then
		    echo "$line"
		    cp "$temp_file" "$filename"
				
		fi
		>temp
    	else
		touch $filename
		echo "$line INIT"
		curl -s $line -o "$filename"
        fi
}

{
while IFS='' read -r line || [[ -n "$line" ]]; do
	check $line &
done < "$1"
wait
}
