#!/bin/bash
FILENAME="$1"
for match in $(grep -E '^```.+$' "$FILENAME" | sort | uniq)
do
    echo -n "$match " | tail -c +4
done
