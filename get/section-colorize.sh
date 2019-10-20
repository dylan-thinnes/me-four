URL="$1"
if [[ -n "$URL" ]]
then
    selector=".section[data-url=\"$URL\"] > .section-container"
else
    selector=".section[data-url] > .section-container"
fi

if [[ "$URL" == "/projects" ]]
then
    color="#44af69"
elif [[ "$URL" == "/blog" ]]
then
    color="#f8333c"
elif [[ "$URL" == "/contact" ]]
then
    color="#2b9eb3"
elif [[ "$URL" == "/about" ]]
then
    color="#ff6600"
elif [[ "$URL" == "/links" ]]
then
    color="#732d9c"
else
    color="#333333"
fi

echo "
<style>
$selector {
    border-color: $color;
}
$selector .text {
    color: $color;
}
$selector h1, $selector h2, $selector h3, $selector h4, $selector h5, $selector h6 {
    color: $color;
}
$selector h1, $selector h2 {
    border-bottom: 2px solid $color;
    padding-bottom: 4pt;
}
</style>
"
