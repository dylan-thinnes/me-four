RAW=`./get/meta.sh "$1" | head -n1`
if [[ -f "./clone/$RAW" ]]
then
    echo "/clone/$RAW"
else
    echo "$RAW"
fi
