#!/bin/bash
ls src/articles/*.article
if ./testing.sh; then
    ls src/articles/drafts/*.article
fi
