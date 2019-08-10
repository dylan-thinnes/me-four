echo '<div class="toc">'
echo '<h3>Table of Contents</h3>'

./get/body.sh $1 | ./utils/markdown.sh | perl -e '''
while (<>) {
    if (m/<h(\d)[^>]*id="([^"]+)"[^>]*>(.+)<\/h\1>/) {
        print " "x(($1-2)*4);
        print "* ";
        print "[${3}](#${2})";
        print "\n";
    }
}
''' | ./utils/markdown.sh

echo '</div>'
