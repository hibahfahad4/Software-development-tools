#!/bin/bash
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
