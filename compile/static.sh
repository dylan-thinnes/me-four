#!/bin/bash
mkdir -p ./dist/static
shopt -s globstar
for pathname in static/**
do
    if [[ -f "$pathname" ]]
    then
        ./utils/static/copy.sh "$pathname"
    fi
done
