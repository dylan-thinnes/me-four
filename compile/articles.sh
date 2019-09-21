#!/bin/bash
mkdir -p ./dist/blog
mkdir -p ./dist/nolayout/blog

# Extract articles that need remaking
ARTICLES=$(
    for pathname in $@
    do
        if [[ "$pathname" == "./get/article/makefile.sh" ]]
        then
            for pathname in `./get/article/glob.sh`
            do
                BASENAME=${pathname##*/}
                BASENAME=${BASENAME%%.*}
                mkdir -p makefiles/articles
                ./get/article/makefile.sh "$pathname" > makefiles/articles/$BASENAME
            done
        elif [[ "$pathname" =~ ".article" ]]
        then
            echo $pathname
        else
            ./get/article/glob.sh
        fi
    done | sort | uniq
)

for pathname in $ARTICLES
do
    if [[ -f "$pathname" ]] && [[ "$pathname" =~ ".article" ]]
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

        BASENAME=${pathname##*/}
        BASENAME=${BASENAME%%.*}
        mkdir -p makefiles/articles
        ./get/article/makefile.sh "$pathname" > makefiles/articles/$BASENAME

        ./compile/makelog.sh $pathname
    fi
done
