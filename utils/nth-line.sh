#!/bin/bash
CONTENT=`cat ${@:2}`
MAX=`echo "$CONTENT" | wc -l`
N="$1"

if (( $N > $MAX )); then
    false # Return false
else
    echo "$CONTENT" | tail -n +$N | head -n1
    true  # Return true
fi
