# Extract link from project metadata
LINK=`./get/project/link.sh "$1"`

# Extract deprecation status
if [[ ${LINK:0:1} == "#" ]]
then
    echo "true"
else
    echo "false"
fi
