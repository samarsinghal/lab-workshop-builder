#!/bin/bash

export dir_path=workshop/content
# Prompt the user for content name and title
read -p "Enter content name: " content_name
read -p "Enter title: " title

# Prompt the user for the directory path
# read -p "Enter the directory path: " dir_path

# Check if the directory exists
if [ ! -d "$dir_path" ]; then
    echo "Directory does not exist."
    exit 1
fi

# Display all files in the directory that match the pattern XX-filename
echo "Files in the directory '$dir_path':"
files=($(ls "$dir_path" | grep -E '^[0-9]{2}-'))

# Check if there are matching files
if [ ${#files[@]} -eq 0 ]; then
    echo "No files found with the naming pattern 'XX-filename'."
    exit 1
fi

# Display the files
for i in "${!files[@]}"; do
    echo "$i: ${files[$i]}"
done

# Prompt the user to provide the order of files
echo "Provide the new order of files by specifying their indices separated by space (e.g., 2 0 1):"
read -a order

# Check if the order array length matches the files array length
if [ ${#order[@]} -ne ${#files[@]} ]; then
    echo "The number of indices provided does not match the number of files."
    exit 1
fi

# Create a temporary directory to avoid conflicts while renaming
tmp_dir=$(mktemp -d)

# Move files to temporary directory with new order
for i in "${!order[@]}"; do
    idx=${order[$i]}
    mv "$dir_path/${files[$idx]}" "$tmp_dir/$(printf '%02d' $i)-${files[$idx]:3}"
done

# Move files back to the original directory
mv "$tmp_dir"/* "$dir_path"
rmdir "$tmp_dir"

echo "Files have been reordered successfully."