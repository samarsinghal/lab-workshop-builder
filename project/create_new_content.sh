#!/bin/bash

# Prompt the user for the workshop name
directory=~/exercises/$NEW_WORKSHOP_NAME/workshop/content

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory does not exist."
    exit 1
fi

# Display all files in the directory that match the pattern XX-filename
echo "Workshop content: "
files=($(ls "$directory" | grep -E '^[0-9]{2}-'))

# Display the files
for i in "${!files[@]}"; do
    echo "$i: ${files[$i]}"
done

# Find the next available order number
order_numbers=()
for file in "${files[@]}"; do
    order=$(echo "$file" | cut -d '-' -f 1)
    order_numbers+=("$order")
done

# Find the smallest missing order number
next_order=0
while true; do
    formatted_order=$(printf '%02d' $next_order)
    if [[ ! " ${order_numbers[@]} " =~ " ${formatted_order} " ]]; then
        break
    fi
    next_order=$((next_order + 1))
done

# Ask for workshop details
read -p "Enter workshop content name: " content_name
read -p "Enter workshop content title: " content_title


# Ensure the order number is two digits
order_number=$(printf '%02d' $next_order)


# Create the new file with the given details
new_file_name="$order_number-$(echo "$content_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
touch "$directory/$new_file_name.md"

echo -e "---\ntitle: $content_title\n---" >> "$directory/$new_file_name.md"


echo $new_file_name created

# Display all files in the directory that match the pattern XX-filename
echo "Workshop content: "
files=($(ls "$directory" | grep -E '^[0-9]{2}-'))

# Display the files
for i in "${!files[@]}"; do
    echo "$i: ${files[$i]}"
done

# # Update config.yaml
# config_file=~/exercises/$NEW_WORKSHOP_NAME/workshop/config.yaml

# # Insert the new file in the correct position in the steps section
# sed -i "/steps:/,/params:/!b;/params:/!{s|^|&\n      - $new_file_name|;b};:a;n;ba" $config_file

# # Insert the new module in the correct position in the modules section
# sed -i "/modules:/,/params:/!b;/params:/!{s|^|&\n- name: $new_file_name\n  title: $content_title|;b};:a;n;ba" $config_file

