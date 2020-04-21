INPUT=`cat`
COMMAND_LINES=`echo "$INPUT" | egrep '<%=.*=%>' -o`
COMMANDS_ON=1
while IFS= read -r line
do
    COMMAND="${line#<%=}"
    COMMAND="${COMMAND%=%>}"
    if [[ "$COMMAND" == commands_on ]]; then
        COMMANDS_ON=1
        continue
    elif [[ "$COMMAND" == commands_off ]]; then
        COMMANDS_ON=0
        continue
    elif [[ "$COMMANDS_ON" == 0 ]]; then
        continue
    fi
    RESULT=`$COMMAND $@`
    INPUT="${INPUT//$line/$RESULT}"
done < <(echo "$COMMAND_LINES")
INPUT="${INPUT//<%=commands_off=%>/}"
INPUT="${INPUT//<%=commands_on=%>/}"
echo "$INPUT"
