while IFS= read -r line
do
    if [[ -z $line ]]
    then
        break
    fi
    echo "$line"
done < "$1"
