#!/bin/bash
SECTION=$1
mkdir -p ./dist/$SECTION
mkdir -p ./dist/nolayout/$SECTION
DATA=`./get/html-assets/$SECTION/html.sh`
echo "$DATA" | ./get/index.sh "`./get/html-assets/$SECTION/title.sh`" "/$SECTION" \
             > ./dist/$SECTION/index.html
echo "$DATA" > ./dist/nolayout/$SECTION/index.html

