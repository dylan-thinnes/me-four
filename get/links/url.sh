RAW=`./get/meta.sh "$1" | ./utils/nth-line.sh 1`
if [[ -f "./clone/$RAW" ]]
then
    echo "/clone/$RAW"
else
    echo "$RAW"
fi
