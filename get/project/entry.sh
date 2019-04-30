# Extract title from project metadata
TITLE=`./get/project/title.sh "$1"`

# Extract link from project metadata
LINK=`./get/project/link.sh "$1"`

# Extract deprecation status
DEPRECATED=`./get/project/deprecated.sh "$1"`
if [[ $DEPRECATED == "true" ]]
then
    OPENING="<div class='entry disabled'>"
    CLOSING="</div>"
else
    OPENING="<a href='$LINK' class='entry'>"
    CLOSING="</a>"
fi

# Extract body from project metadata
BODY=`./get/body.sh "$1"`

echo "\
$OPENING
  <b class='text'>$TITLE</b><br>
  <small>
    $BODY
  </small>
$CLOSING\
"

