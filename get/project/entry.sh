# Extract title from project metadata
TITLE=`./get/project/title.sh "$1"`

# Extract link from project metadata
LINK=`./get/project/link.sh "$1"`

# Extract deprecation status
DEPRECATED=`./get/project/deprecated.sh "$1"`
if [[ $DEPRECATED == "true" ]]
then
    OPENING="<a class='entry disabled'>"
    CLOSING="</a>"
else
    OPENING="<a href='$LINK' class='entry'>"
    CLOSING="</a>"
fi

# Extract body from project metadata
BODY=`./get/body.sh "$1"`

echo "\
<div>
  $OPENING
    <h3 class='text'>$TITLE</h3>
    $BODY
  $CLOSING\
</div>
"

