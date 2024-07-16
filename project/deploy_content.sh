#!/bin/bash
# 
# Purpose:
#   Deploy the desireded content file to eduk8s workshop.
#

directory=~/exercises/$NEW_WORKSHOP_NAME/workshop/content

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory does not exist."
    exit 1
fi

# Display all files in the directory
echo "Workshop content:"
files=($(ls "$directory" | grep -E '^[0-9]{2}-'))

# Display the files
for i in "${!files[@]}"; do
    echo "$i: ${files[$i]}"
done

# Ask user to choose a file to test
read -p "Enter the index of the content you want to move: " file_index
if ! [[ "$file_index" =~ ^[0-9]+$ ]] || [ "$file_index" -ge "${#files[@]}" ]; then
    echo "Invalid index."
    exit 1
fi

export selected_file=${files[$file_index]}

cp -ur ~/exercises/$NEW_WORKSHOP_NAME/workshop/content /opt/workshop/content/
rm /opt/workshop/content/04-content-tester.md
cp ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/04-content-tester.md

# rm /opt/workshop/content/labs/testcase.md
# rm /opt/workshop/content/labs/testcase.md.in
# rm /opt/workshop/content/labs/setup.md

# cp -u ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/testcase.md.in
# cp -u ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/setup.md
# cp -u ~/exercises/$NEW_WORKSHOP_NAME/workshop/content/$selected_file /opt/workshop/content/labs/testcase.md





# sh deploy.sh scenarios/devops/sc02-tc01.md


# cp -ur scenarios /opt/workshop/content/
# rm /opt/workshop/content/labs/testcase.md
# rm /opt/workshop/content/labs/testcase.md.in
# rm /opt/workshop/content/labs/setup.md

# testcasename=$(basename "$1")
# cp -u $1 /opt/workshop/content/labs/testcase.md.in
# cp -u scenarios/env/$testcasename /opt/workshop/content/labs/setup.md
# cp -u $1 /opt/workshop/content/labs/testcase.md