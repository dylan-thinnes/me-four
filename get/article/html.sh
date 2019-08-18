# Extract title from article metadata
TITLE=`./get/article/title.sh "$1"`

# Extract author from article metadata
AUTHOR=`./get/article/author.sh "$1"`

# Extract blurb from article metadata
BLURB=`./get/article/blurb.sh "$1"`

# Extract date from stat
DATE=`date -r "$1"`

# Extract server path from filename
FILENAME=`basename "$1"`
FILENAME=${FILENAME%.*}

# Get markdown
MARKDOWN=`./get/body.sh "$1"`

echo "\
# $TITLE
By $AUTHOR, *Last Edited $DATE*
" | ./utils/markdown.sh

./get/article/toc.sh "$1"
echo "$MARKDOWN" | ./utils/markdown.sh --no-highlight
./get/article/languages.sh "$1"
