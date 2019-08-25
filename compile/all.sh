#!/bin/bash
for makefile in `find ./makefiles -type f -not -name ".*"`
do
    if [[ -f "$makefile" ]] && [[ "$makefile" != "./makefiles/main" ]]
    then
        make -f "$makefile"
    fi
done
make -f ./makefiles/main $@
