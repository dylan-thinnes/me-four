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
            echo "$MIN" > "$pathname"
        elif [[ "$EXT" == "css" ]]
        then
            echo "Minifying $pathname"
            MIN=`./utils/minify/css.sh "$pathname"`
            echo "$MIN" > "$pathname"
        elif [[ "$EXT" == "html" ]]
        then
            echo "Minifying $pathname"
            MIN=`./utils/minify/html.sh "$pathname"`
            echo "$MIN" > "$pathname"
        fi
    fi
done
