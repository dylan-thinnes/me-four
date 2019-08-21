#!/bin/bash
for arg in $@
do
    FILENAME="./$arg"
    DIR="${FILENAME%/*}"
    mkdir -p "./makelog/$DIR" && touch "./makelog/$FILENAME"
done
