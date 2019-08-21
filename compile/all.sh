#!/bin/bash
for makefile in `find ./makefiles`
do
    if [[ -f "$makefile" ]]
    then
        make -f "$makefile"
    fi
done
