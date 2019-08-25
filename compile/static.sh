#!/bin/bash
mkdir -p ./dist/static
for pathname in $@
do
    if [[ -f "$pathname" ]]
    then
        ./utils/static/copy.sh "$pathname"
    fi
done
