(
    for filename in `ls src/streams/*.link`
    do
        PRECEDENCE=`./get/streams/precedence.sh "$filename"`
        echo "$PRECEDENCE $filename"
    done 
) | sort -gr | cut -d " " -f 2- | (
    while read line
    do
        ./get/streams/entry.sh "$line"
    done
)
