# Retrieve all languages mentioned in code blocks in the article
LANGUAGES=`./get/article/languages.sh $1`

if [[ -n $LANGUAGES ]]
then
    echo """
<link rel='stylesheet' href='/`./utils/static/path.sh static/prism/themes/prism-okaidia.css`' />
<script src='/`./utils/static/path.sh static/prism/components/prism-core.js`'></script>
    """
    for language in $LANGUAGES
    do
        if [[ -f "./static/prism/components/prism-$language.js" ]]
        then
            echo "<script>"
            cat "static/prism/components/prism-$language.js" | ./utils/minify/js.sh
            echo "</script>"
        fi
    done
fi

