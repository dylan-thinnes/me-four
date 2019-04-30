if [[ -f "$1" ]]
then
    TIMESTAMP=`date -r "$1" +%Y%m%d-%H%M%S-%N`
    PATH_EXT="${1##*.}"
    PATH_WITHOUT_EXT="${1%.*}"

    echo "$PATH_WITHOUT_EXT-$TIMESTAMP.$PATH_EXT"
fi
