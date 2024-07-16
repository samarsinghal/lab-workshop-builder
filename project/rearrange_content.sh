#!/bin/bash

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

# Ask user to choose a file to move
read -p "Enter the index of the content you want to move: " file_index
if ! [[ "$file_index" =~ ^[0-9]+$ ]] || [ "$file_index" -ge "${#files[@]}" ]; then
    echo "Invalid index."
    exit 1
fi

# Ask for the new position
read -p "Enter the new position: " new_position
if ! [[ "$new_position" =~ ^[0-9]+$ ]] || [ "$new_position" -ge "${#files[@]}" ]; then
    echo "Invalid position."
    exit 1
fi

# Get the selected file
selected_file=${files[$file_index]}

# Remove the selected file from the array
unset 'files[$file_index]'
files=("${files[@]}")  # Reindex the array

# Insert the file at the new position
files=("${files[@]:0:$new_position}" "$selected_file" "${files[@]:$new_position}")

# Create a temporary directory to move files safely
temp_dir=$(mktemp -d)

# Move all files to the temporary directory with new names
for i in "${!files[@]}"; do
    new_name=$(printf '%02d' $i)-${files[$i]:3}
    mv "$directory/${files[$i]}" "$temp_dir/$new_name"
    files[$i]=$new_name
done

# Move files back from the temporary directory to the original directory
mv $temp_dir/* "$directory"

# Clean up the temporary directory
rmdir $temp_dir

# Display all files in the directory
echo "Workshop content: "
files=($(ls "$directory" | grep -E '^[0-9]{2}-'))

# Display the files
for i in "${!files[@]}"; do
    echo "$i: ${files[$i]}"
done


# # Update config.yaml
# config_file=~/exercises/$NEW_WORKSHOP_NAME/workshop/config.yaml

# # Update the steps section
# for i in "${!files[@]}"; do
#     sed -i "/steps:/,/params:/!b;/params:/!{s|^\(steps:\).*\n|\1\n      - ${files[$i]}|;b};:a;n;ba" $config_file
# done

# # Update the modules section
# modules_section=""
# for file in "${files[@]}"; do
#     title=$(echo "$file" | cut -d '-' -f 2- | sed 's/_/ /g' | sed 's/.md//')
#     modules_section+="  - name: $file\n    title: $title\n"
# done
# sed -i "/modules:/,/params:/!b;/params:/!{s|^\(modules:\).*\n|\1\n$modules_section|;b};:a;n;ba" $config_file
