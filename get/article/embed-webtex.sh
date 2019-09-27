INPUT=`cat`
LINKS=`echo "$INPUT" | egrep 'src="https://latex\.codecogs\.com/png\.latex\?[^"]*"' -o | sort | uniq`
while IFS= read -r line
do
    LINK="${line#src=\"}"
    LINK="${LINK%\"}"
    LATEX="${LINK#*png.latex?}"
    if [[ "$LINK" == "" ]]; then continue; fi

    # Memoize previous images
    if [[ -f "./webtex-hist/$LATEX" ]]; then
        RESULT=`cat "./webtex-hist/$LATEX"`
    else
        DATA=$(curl -s "$LINK" | base64 | tr -d "\n")
        RESULT="src=\"data:image/png;base64,$DATA\""

        mkdir -p ./webtex-hist
        echo "$RESULT" > "./webtex-hist/$LATEX"
    fi
    INPUT="${INPUT//$line/$RESULT}"
done < <(echo "$LINKS")
echo "$INPUT"
