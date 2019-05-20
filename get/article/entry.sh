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
<p>
    <a href='$BASEPATH' class='entry'>
      <b class='text'>$TITLE</b><br>
      <small>
        By $AUTHOR, <i>Last Edited $DATE</i><br>
        $BLURB

      </small>
    </a>\
</p>
"
