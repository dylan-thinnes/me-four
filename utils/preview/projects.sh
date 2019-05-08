(
    for filename in src/projects/*.project
    do
        PRECEDENCE=`./get/project/precedence.sh "$filename"`
        echo "$PRECEDENCE $filename"
    done 
) | sort -gr | cut -d " " -f 2- | (
    while read line
    do
        TITLE=`./get/project/title.sh "$line"`
        PRECEDENCE=`./get/project/precedence.sh "$line"`
        printf "%5d | %s\n" "$PRECEDENCE" "$TITLE"
    done
)
