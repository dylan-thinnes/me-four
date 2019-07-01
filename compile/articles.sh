#!/bin/bash
shopt -s globstar
mkdir -p ./dist/blog
mkdir -p ./dist/nolayout/blog
for pathname in src/articles/**
do
    if [[ -f "$pathname" ]]
    then
        DATA=`./get/article/html.sh "$pathname"`
        BASEPATH=`./get/article/basepath.sh "$pathname"`
        ROOTPATH="./dist$BASEPATH"
        NOLAYOUTPATH="./dist/nolayout$BASEPATH"

        mkdir -p "$ROOTPATH"
        mkdir -p "$NOLAYOUTPATH"
        TITLE=`./get/article/title.sh "$pathname"`

        echo "$DATA" | ./get/index.sh "$TITLE" "$BASEPATH/index.html" > $ROOTPATH/index.html
        echo "$DATA" > $NOLAYOUTPATH/index.html
    fi
done

