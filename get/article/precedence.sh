EXPLICIT_PREC=`./get/meta.sh "$1" | ./utils/nth-line.sh 4`
if [[ $? == 1 ]]
then
    stat --format="%Y" "$1"
else
    echo $EXPLICIT_PREC
fi
