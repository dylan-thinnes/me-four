TITLE="$1"
if [[ -z "$TITLE" ]]
then
    TITLE="Dylan Joseph Thinnes"
fi
URL="$2"
if [[ "$URL" == "/" ]]
then
    BODYCLASS=""
    CONTENT="
        <div class='section selected' data-url='/' style='opacity: 0'></div>
    "
else
    BODYCLASS="open"
    CONTENT="
        <div class='section selected' data-url='$URL'>
            <title>$TITLE</title>
            <div class='section-container'>
                `cat -`
            </div>
        </div>
    "
fi

echo "
<!DOCTYPE html>
<html>
    <head>
        <title>$TITLE</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <meta charset='utf-8'>
        `./get/html-assets/favicon/html.sh`
        <link href='/`./utils/static/path.sh static/style.css`' rel='stylesheet' />
`./get/section-colorize.sh`
    </head>

    <body class='$BODYCLASS'>
        <div class='spacer'></div>
        `./get/html-assets/profile/html.sh \"$URL\"`
        <div id='name'><a href='/' class='reset'>Dylan Thinnes</a></div>
        <div id='social'>
            <a class='contact-bg' href='/contact'>contact</a>
            <a class='projects-bg' href='/projects'>projects</a>
            <a class='blog-bg' href='/blog'>blog</a>
            <a class='about-bg' data-jslicense='1' href='/about'>about</a>
        </div>
        <div id='blurb'>
            I am a student of Comp Sci at the University of
            Edinburgh.<br/>In my spare time, I enjoy camping, Aikido, and
            coding.  
        </div>
        <div id='content'>
            $CONTENT
            <div class='section' id='loading' style='display: none'>
                <div class='text'>Loading...</div>
            </div>
        </div>
        <div class='spacer'></div>
        <script src='/`./utils/static/path.sh static/app.js`'></script>
    </body>
</html>
"
