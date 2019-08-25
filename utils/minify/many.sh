#!/bin/bash
for pathname in $@
do
    if [[ -f "$pathname" ]]
    then
        EXT=${pathname##*.}
        if [[ "$EXT" == "js" ]]
        then
            echo "Minifying $pathname"
            MIN=`./utils/minify/js.sh "$pathname"`
            if [[ $? == 0 ]]
            then
                echo "$MIN" > "$pathname"
            fi
        elif [[ "$EXT" == "css" ]]
        then
            echo "Minifying $pathname"
            MIN=`./utils/minify/css.sh "$pathname"`
            if [[ $? == 0 ]]
            then
                echo "$MIN" > "$pathname"
            fi
        elif [[ "$EXT" == "html" ]]
        then
            echo "Minifying $pathname"
            MIN=`./utils/minify/html.sh "$pathname"`
            if [[ $? == 0 ]]
            then
                echo "$MIN" > "$pathname"
            fi
        fi
    fi
done
