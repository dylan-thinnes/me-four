# Run all commands in one shell (allows multiline loops etc)
.ONESHELL:
SHELL = /bin/bash

# Use the makelog directory to remember when a target was last run
VPATH = ./makelog:.

all : front static_assets blog contact about projects
prod : all minify

static_assets : static/*
	./compile/static.sh
	./compile/makelog.sh static_assets

front : ./get/*.sh static_assets
	echo "" | ./get/index.sh "" "/" > ./dist/index.html
	./compile/makelog.sh front

blog : front ./get/article/* ./get/html-assets/blog/* ./src/articles/*
	./compile/section.sh blog
	./compile/articles.sh
	./compile/makelog.sh blog

contact : front ./get/html-assets/contact/*
	./compile/section.sh contact
	./compile/makelog.sh contact

about : front ./get/html-assets/about/*
	./compile/section.sh about
	./compile/makelog.sh about

projects : front ./get/project/* ./get/html-assets/projects/* ./src/projects/*
	./compile/section.sh projects
	./compile/makelog.sh projects

MINIFIABLE = $(shell find dist/ -type f -name '*.html' -or -name '*.css' -or -name '*.js')
minify : ${MINIFIABLE}
	./utils/minify/many.sh $?
	./compile/makelog.sh minify

.PHONY : clean
clean : 
	rm -r ./dist/*
