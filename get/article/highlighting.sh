# Retrieve all languages mentioned in code blocks in the article
LANGUAGES=`./get/article/languages.sh $1`

if [[ -n $LANGUAGES ]]
then
    echo """
<script src='/`./utils/static/path.sh static/highlight/highlight.js`'></script>
<link rel='stylesheet' href='/`./utils/static/path.sh static/highlight/styles/monokai-sublime.css`' />
    """
    for language in $LANGUAGES
    do
        echo "<script>"
        echo """
hljs.registerLanguage(
    \"$language\", 
    `cat static/highlight/languages/$language.js`
);
        """ | ./utils/minify/js.sh
        echo "</script>"
    done
fi

