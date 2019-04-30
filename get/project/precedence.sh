DEPRECATED=`./get/project/deprecated.sh "$1"`

PRECEDENCE=`./get/meta.sh "$1" | tail -n +3 | head -n1`
if [[ $DEPRECATED == "true" ]]
then
    PRECEDENCE=$((PRECEDENCE - 1000))
else
    PRECEDENCE=$((PRECEDENCE))
fi
echo "$PRECEDENCE"
