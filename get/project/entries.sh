(
    for filename in src/projects/*.project
    do
        PRECEDENCE=`./get/project/precedence.sh "$filename"`
        echo "$PRECEDENCE $filename"
    done 
) | sort -gr | cut -d " " -f 2- | (
    while read line
    do
        ./get/project/entry.sh "$line"
    done
)
