ORIG_FILEPATH="$1"
FILEPATH=`./utils/static/path.sh "$ORIG_FILEPATH"`
FOLDER="dist/${FILEPATH%/*}"
mkdir -p "$FOLDER"
FILETYPE=`file -b $ORIG_FILEPATH`
if [[ "$FILETYPE" =~ "ASCII text" ]]
then
    cat "$ORIG_FILEPATH" | ./utils/run_commands.sh > "dist/$FILEPATH"
else
    cp "$ORIG_FILEPATH" "dist/$FILEPATH"
fi
