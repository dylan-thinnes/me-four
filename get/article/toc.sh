echo '<div class="toc">'
echo '<h3>Table of Contents</h3>'

./get/body.sh $1 | ./utils/markdown.sh | perl -e '''
$_ = join "\n", <>;
$i = 0;
$m = 100;
for my $line (split /\n/, $_) {
    if ($line =~ m/<h(\d)[^>]*id="([^"]+)"[^>]*>(.+)<\/h\1>/) {
        $i += 1;
        if ($m > $1) {
            $m = $1;
        }
    }
}
if ($i > 0) {
    for my $line (split /\n/, $_) {
        if ($line =~ m/<h(\d)[^>]*id="([^"]+)"[^>]*>([^<]+).*<\/h\1>/) {
            print " "x(($1-$m)*4);
            print "* ";
            print "[${3}](#${2})";
            print "\n";
        }
    }
}
''' | ./utils/markdown.sh

echo '</div>'
