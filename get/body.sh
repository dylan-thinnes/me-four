FOUND_EMPTYLINE=""
while IFS= read -r line
do
    if [[ -n $FOUND_EMPTYLINE ]]
    then
        echo "$line"
    fi

    if [[ -z $line ]]
    then
        FOUND_EMPTYLINE="found"
    fi
done < "$1"
