(
    for filename in `./get/article/glob.sh`
    do
        PRECEDENCE=`./get/article/precedence.sh "$filename"`
        echo "$PRECEDENCE $filename"
    done 
) | sort -gr | cut -d " " -f 2- | (
    while read line
    do
        ./get/article/entry.sh "$line"
    done
)
