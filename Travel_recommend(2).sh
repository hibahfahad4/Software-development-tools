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

#### education goal section
case $goal_lower in
  "education")
##Ask user for the type of education
read -p "Type of education (School/Higher): " edu_type
edu_type_lower=$(echo "$edu_type" | tr '[:upper:]' '[:lower:]') ###Convert input to lowercase

# Check for the type of education and display relevant data
if [[ "$edu_type_lower" == "school" ]]; then
edu_section="## Type: School Education"
    elif [[ "$edu_type_lower" == "higher" ]]; then
      edu_section="## Type: Higher Education"
    else
      echo "Invalid type."
      exit 1
fi
;;
esac


