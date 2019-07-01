# Extract title from article metadata
TITLE=`./get/article/title.sh "$1"`

# Extract author from article metadata
AUTHOR=`./get/article/author.sh "$1"`

# Extract blurb from article metadata
BLURB=`./get/article/blurb.sh "$1"`

# Extract date from stat
DATE=`./get/article/date.sh "$1"`

# Extract server path from filename
BASEPATH=`./get/article/basepath.sh "$1"`

echo "\
<div>
    <a href='$BASEPATH' class='entry'>
      <h3 class='text'>$TITLE</h3>
      By $AUTHOR, <i>Last Edited $DATE</i><br>
      $BLURB
    </a>\
</div>
"
