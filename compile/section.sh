#!/bin/bash
SECTION=$1
mkdir -p ./dist/$SECTION
mkdir -p ./dist/nolayout/$SECTION
DATA=`./get/html-assets/$SECTION/html.sh`
TITLE=`./get/html-assets/$SECTION/title.sh`
HTML="""
<title>$TITLE</title>
$DATA
"""
echo "$HTML" | ./get/index.sh "$TITLE" "/$SECTION" \
             > ./dist/$SECTION/index.html
echo "$HTML" > ./dist/nolayout/$SECTION/index.html

