(
    for filename in `ls src/links/*.link`
    do
        PRECEDENCE=`./get/links/precedence.sh "$filename"`
        echo "$PRECEDENCE $filename"
    done 
) | sort -gr | cut -d " " -f 2- | (
    while read line
    do
        ./get/links/entry.sh "$line"
    done
)
