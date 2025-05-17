#!/bin/bash
# Filename to check
DATA_FILE="Data.txt"
# Check if the file exists
if [ -e "$DATA_FILE" ]; then
# Check if the file is readable
if [ -r "$DATA_FILE" ]; then
echo "The file is readable."
else
echo "The file is not readable."
exit 1
fi
else
echo "The file does not exist."
exit 1
fi
# Ask user for number of adults
read -p "Enter number of adults: " adults
# Validate that input is a number
if ! [[ "$adults" =~ ^[0-9]+$ ]]; then
echo "Please enter a valid number."
exit 1
fi
# Classify number of adults
if [ "$adults" -gt 9 ]; then
group="Adults > 9"
else
group="Adults ≤ 9"
fi
# Ask user for budget level
echo "Choose budget level:"
echo "1) Low"
echo "2) Medium"
echo "3) High"
read -p "Enter option (1-3): " budget_choice
# Convert user input to budget label
case $budget_choice in

1) budget="Low";;
2) budget="Medium";;
3) budget="High";;
*) echo "Invalid budget choice." ; exit 1;;
esac
# Display matching destinations
echo "Searching for $budget budget destinations for group: $group"
# Flag to control printing lines within the right section
print=0
# Read the data file line by line
while read -r line; do
# If we reach the correct section (e.g., ## Adults > 9)
if [[ "$line" =~ "## $group" ]]; then
print=1
continue
fi
# If we reach a new section, stop printing
if [[ "$line" =~ "##" && ! "$line" =~ "$group" ]]; then
print=0
fi
# Print destination if budget matches and inside correct section
if [ $print -eq 1 ]; then
# Extract budget from end of line (e.g., "- High")
dest_budget=$(echo "$line" | awk -F '-' '{print $NF}' | xargs)
# If budget matches, print the destination name
if [ "$dest_budget" == "$budget" ]; then
echo "- $(echo "$line" | cut -d'-' -f1 | xargs)"
fi
fi
done < "$DATA_FILE"
#reading from user part

echo "Welcome to the Travel Recommendation Program :) "

# Ask usr for trip goal
read -p "Enter your travel goal (e.g., Education, Entertainment): " goal
goal_lower=$(echo "$goal" | tr '[:upper:]' '[:lower:]') # for easy comparison

# Ask user for num of adults
read -p "Enter number of adults going on the trip: " num_adults

 
file="Data.txt"

echo ""
echo "Fetching suggestions for you..."
echo "--------------------------------"

# Case to check the goal, filter based on file content 
case $goal_lower in
  "education")
    #Example:For education > ask type of education
    read -p "Type of education (School/Higher): " edu_type
    edu_type_lower=$(echo "$edu_type" | tr '[:upper:]' '[:lower:]')

    if [[ "$edu_type_lower" == "school" ]]; then
      # Show School Education recommendations
      awk '/## Type: School Education/{flag=1; next} /##/{flag=0} flag && NF' "$file"
    elif [[ "$edu_type_lower" == "higher" ]]; then
    
      # Show Higher Education recommendations
      awk '/## Type: Higher Education/{flag=1; next} /##/{flag=0} flag && NF' "$file"
    else
      echo "Sorry, type not recognized. Please enter School or Higher."
    fi
    ;;

  "entertainment")
    #Example: For entertainment> check the number of adults
    if (( num_adults > 9 )); then
      awk '/## Adults > 9/{flag=1; next} /##/{flag=0} flag && NF' "$file"
    else
      awk '/## Adults ≤ 9/{flag=1; next} /##/{flag=0} flag && NF' "$file"
    fi
    ;;

  *)
    echo "Sorry, this goal is not available in the current version."
    ;;
esac

echo "--------------------------------"
echo "Thank you for using our program!"
