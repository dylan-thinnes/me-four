# Run all commands in one shell (allows multiline loops etc)
.ONESHELL:
SHELL = /bin/bash

# Use the makelog directory to remember when a target was last run
VPATH = ./makelog:.

static_assets : static/*
	./compile/static.sh
	./compile/makelog.sh static_assets

front : get/index.sh
	echo "" | ./get/index.sh "" "/" > ./dist/index.html
	./compile/makelog.sh front

blog : front ./get/html-assets/blog/* ./get/article/*
	./compile/section.sh blog
	./compile/articles.sh
	./compile/makelog.sh blog

contact : front ./get/html-assets/contact/* ./get/article/*
	./compile/section.sh contact
	./compile/makelog.sh contact

about : front ./get/html-assets/about/* ./get/article/*
	./compile/section.sh about
	./compile/makelog.sh about

projects : front ./get/html-assets/projects/* ./get/article/*
	./compile/section.sh projects
	./compile/makelog.sh projects

all : front static_assets blog contact about projects
prod : all minify

MINIFIABLE = $(shell find dist/ -type f -name '*.html' -or -name '*.css' -or -name '*.js')
minify : ${MINIFIABLE}
	./utils/minify/many.sh $?
	./compile/makelog.sh minify

.PHONY : clean
clean : 
	rm -r ./dist/*
