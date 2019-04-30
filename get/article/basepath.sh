# Extract server path from filename
FILENAME=`basename "$1"`
FILENAME=${FILENAME%.*}

echo "/blog/$FILENAME"
