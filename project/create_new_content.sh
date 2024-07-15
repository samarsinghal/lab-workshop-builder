```bash
#!/bin/bash

# Prompt the user for the directory path
read -p "Enter the directory path: " dir_path

# Check if the directory exists
if [ ! -d "$dir_path" ]; then
    echo "Directory does not exist."
    exit 1
fi

# Display all files in the directory that match the pattern XX-filename
echo "Files in the directory '$dir_path':"
files=($(ls "$dir_path" | grep -E '^[0-9]{2}-'))

# Display the files
for i in "${!files[@]}"; do
    echo "$i: ${files[$i]}"
done

# Ask for workshop details
read -p "Enter workshop name: " NEW_WORKSHOP_NAME
read -p "Enter workshop title: " workshop_title
read -p "Enter the order number for the new file: " order_number

# Create the new file with the given details
new_file_name=$(printf '%02d' $order_number)-$NEW_WORKSHOP_NAME-$workshop_title
touch "$dir_path/$new_file_name"
echo "New file created: $new_file_name"

# Insert the new file into the files array at the specified position
files=("${files[@]:0:$order_number}" "$new_file_name" "${files[@]:$order_number}")

# Renumber all files to maintain the correct order
for i in "${!files[@]}"; do
    new_name=$(printf '%02d' $i)-${files[$i]:3}
    mv "$dir_path/${files[$i]}" "$dir_path/$new_name"
    files[$i]=$new_name
done

echo "Files have been reordered successfully."
```