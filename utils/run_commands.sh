INPUT=`cat`
COMMAND_LINES=`echo "$INPUT" | egrep '<%=.*=%>' -o`
while IFS= read -r line
do
    COMMAND="${line#<%=}"
    COMMAND="${COMMAND%=%>}"
    RESULT=`$COMMAND $@`
    INPUT="${INPUT//$line/$RESULT}"
done < <(echo "$COMMAND_LINES")
echo "$INPUT"
