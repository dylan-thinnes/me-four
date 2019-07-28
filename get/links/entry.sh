# Extract url for link
URL=`./get/links/url.sh "$1"`

# Extract url for link
TITLE=`./get/links/title.sh "$1"`

# Extract url for link
DESCRIPTION=`./get/links/description.sh "$1"`

echo """
<div>
    <a href='$URL' data-disable-mocking='true' class='entry'>
      <h3 class='text'>$TITLE</h3>
      $DESCRIPTION
    </a>
</div>
"""

