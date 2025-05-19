#!/bin/bash

# Entertainment section
"entertainment")
# Classify number of adults (group)
if [ "$adults" -gt 9 ]; then
group="Adults > 9"
else
group="Adults ≤ 9"
fi

echo "Searching for $budget budget destinations for group: $group" 
print=0
while read -r line; do
# Check if the line matches the group
if [[ "$line" =~ "## $group" ]]; then
print=1
continue
fi
# If we encounter another section, stop printing
if [[ "$line" =~ "##" && ! "$line" =~ "$group" ]]; then
print=0
fi
fi

