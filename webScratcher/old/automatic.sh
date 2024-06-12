#!/bin/bash

# Prompt the user to enter a URL
read -p "Enter the URL to crawl: " url

# Remove special characters from the URL to create the folder name
folder_name=$(echo "$url" | sed 's/[^a-zA-Z0-9]//g')

# Create the folder
mkdir -p "./$folder_name"

# Run gospider with the provided URL and save output to the folder
gospider --site "$url" --depth 0 --concurrent 5 --threads 2 --output "./$folder_name" --user-agent "web"

# Get the first file within the folder
input_file=$(find "./$folder_name" -type f | head -n 1)

if [ -z "$input_file" ]; then
    echo "No files found in the folder."
    exit 1
fi

# Convert the file to a text format
output_file="${input_file%.*}.txt"
mv "$input_file" "$output_file"

# Check if the input file exists
if [[ ! -f "$output_file" ]]; then
    echo "Input file not found!"
    exit 1
fi

# List of allowed file extensions
allowed_extensions="pdf|doc|docx|ppt|pptx|xls|xlsx"

# Read the file and extract URLs
while IFS= read -r line; do
    # Use regex to extract URLs
    if [[ $line =~ (https?|ftp)://[^\ ]+ ]]; then
        url="${BASH_REMATCH[0]}"
        # Check if the URL ends with an allowed file extension
        if [[ $url =~ \.($allowed_extensions)$ ]]; then
            echo "Downloading $url"
            wget "$url"
        else
            echo "URL does not match allowed file types: $url"
        fi
    else
        echo "No URL found in line: $line"
    fi
done < "$output_file"
