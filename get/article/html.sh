# Extract title from article metadata
TITLE=`./get/article/title.sh "$1"`

# Extract author from article metadata
AUTHOR=`./get/article/author.sh "$1"`

# Extract blurb from article metadata
BLURB=`./get/article/blurb.sh "$1"`

# Extract date from stat
DATE=`./get/article/date.sh "$1"`

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
echo "$MARKDOWN" | ./utils/run_commands.sh | ./utils/markdown.sh --no-highlight | ./get/article/embed-webtex.sh
./get/article/highlighting.sh "$1"
