#!/bin/bash
mkdir -p ./dist/blog
mkdir -p ./dist/nolayout/blog
for pathname in src/articles/*
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

        HTML="""
            <title>$TITLE</title>
            $DATA
        """

        echo "$HTML" | ./get/index.sh "$TITLE" "$BASEPATH/index.html" > $ROOTPATH/index.html
        echo "$HTML" > $NOLAYOUTPATH/index.html
    fi
done


