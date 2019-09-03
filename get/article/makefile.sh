#!/bin/bash
DEPENDENCY_LANGUAGES=$(
    for language in `./get/article/languages.sh $1`
    do
        echo -n "./static/prism/components/prism-$language.js "
    done
)
echo """
VPATH = ./makelog:.

./makelog/$1 : $DEPENDENCY_LANGUAGES
	./compile/articles.sh $1
	./compile/makelog.sh $1
"""
