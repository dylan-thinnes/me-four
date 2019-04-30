URL="$1"
if [[ "$URL" == "/" ]]
then
    PROFILE_PATH=`./utils/static/path.sh static/profile.jpg`
    PROFILE_STYLE="style='background-image: url(/$PROFILE_PATH);'"
fi
echo "$PROFILE_STYLE"
