#!/bin/bash
FILENAME="$1"
ORIG_LANGUAGES=$(
for match in $(grep -E '^```.+$' "$FILENAME" | awk '!x[$0]++')
do
    echo $match | tail -c +4
done
)

# De-alias given list of languages
dealias () {
    local LANG_ARRAY=$(
        for w in $@
        do
            echo $w
        done | jq -nR '[inputs]'
    )
    cat ./static/prism/components.json | jq -r """
        .languages | to_entries | .[] 
    |   select(
            (
                ([.value.alias] | flatten) as \$aliases
            |   \$aliases - $LANG_ARRAY != \$aliases
            ) or (
                $LANG_ARRAY - [.key] != $LANG_ARRAY
            )
        )
    |   .key
    """
}

# Determine prerequisites of a single language
prerequisites () {
    local NAME=$1
    cat ./static/prism/components.json | jq -r """
    .languages | .[\"$NAME\"] | .require | (arrays | .[]), (scalars | values)
    """
}

# Ordered prerequisite tree for a single language
prereq_tree () {
    local NAME="$1"
    local PREREQS=`prerequisites "$NAME"`
    for lang in $PREREQS
    do
        prereq_tree $lang
    done
    echo "$NAME"
}

for lang in `dealias $ORIG_LANGUAGES`
do
    prereq_tree $lang
done | awk '!x[$0]++'
