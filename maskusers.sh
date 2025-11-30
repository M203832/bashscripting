#!/bin/bash

# Ensure first argument is a valid file
if [ ! -f "$1" ]; then
    echo "Error: missing or invalid filename."
    exit 1
fi

file="$1"

# Print header
echo "# time src dest action"

# If second argument is "1", apply single mask rule
if [ "$2" = "1" ]; then
    # Replace the first field after time with USER
    sed 's/^\([^ ]* [^ ]*\)[^ ]*/\1USER/' "$file"

else
    # Apply two masking patterns:
    # 1) Mask username after timestamp
    sed 's/^\([^ ]* [^ ]*\)[^ ]*/\1USER/' "$file" | \
    # 2) Mask if log contains USER keyword
    sed 's/^\([^ ]* USER \)[^ ]*/\1USER/'
fi
