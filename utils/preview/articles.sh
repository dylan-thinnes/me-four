(
    for filename in src/articles/*.article
    do
        PRECEDENCE=`./get/article/precedence.sh "$filename"`
        echo "$PRECEDENCE $filename"
    done 
) | sort -gr | cut -d " " -f 2- | (
    while read line
    do
        TITLE=`./get/article/title.sh "$line"`
        DATE=`./get/article/date.sh "$line"`
        printf "%35s | %s\n" "$DATE" "$TITLE"
    done
)
