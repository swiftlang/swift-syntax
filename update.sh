#!/bin/bash

# Iterate over each file that contains the copyright text
grep -rl "Copyright (c) 2014 - 2024" . | while read -r file; do
    # Extract the year of the first commit of the file
    year=$(git log --format="%ai" --diff-filter=A -- "$file" | tail -1 | cut -d '-' -f 1)
    # If a year was found
    if [[ ! -z "$year" ]]; then
        # Replace the copyright text with the new date range
        sed -i '' "s/Copyright (c) 2014 - 2024/Copyright (c) $year - 2024/g" "$file"
    fi
done
