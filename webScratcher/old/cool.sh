#!/bin/bash

rm -rf url_progress.txt
rm -rf url_queue.txt
rm -rf allowed_extensions.txt
# Clean up the metadata from the last process


QUEUE_FILE="url_queue.txt"
PROGRESS_FILE="url_progress.txt"
EXTENSION_FILE="allowed_extensions.txt"

# Function to initialize the queue and progress files
initialize_files() {
    if [ ! -f "$QUEUE_FILE" ]; then
        touch "$QUEUE_FILE"
    fi

    if [ ! -f "$PROGRESS_FILE" ]; then
        echo 0 > "$PROGRESS_FILE"
    fi

    if [ ! -f "$EXTENSION_FILE" ]; then
        touch "$EXTENSION_FILE"
    fi
}

# Function to add URLs to the queue
add_urls_to_queue() {
    read -p "Enter the URL(s) to crawl (single URL or comma-separated): " url_input
    IFS=',' read -ra urls <<< "$url_input"
    for url in "${urls[@]}"; do
        echo "$url" >> "$QUEUE_FILE"
    done
}

# Function to select allowed file extensions
select_allowed_extensions() {
    ext_options=("pdf" "doc" "docx" "ppt" "pptx" "xls" "xlsx")
    selected_ext=$(zenity --list --checklist \
        --title="Select Allowed File Extensions" \
        --text="Choose the allowed file extensions:" \
        --column="Select" --column="Extension" \
        FALSE "${ext_options[@]}")

    if [[ -z "$selected_ext" ]]; then
        echo "No file extensions selected."
        exit 1
    fi

    # Convert selected extensions to pipe-separated format
    selected_ext=$(echo "$selected_ext" | tr "|" "\n")
    echo "$selected_ext" > "$EXTENSION_FILE"
}

# Function to get the next URL from the queue
get_next_url() {
    local index
    index=$(cat "$PROGRESS_FILE")
    local url
    url=$(sed -n "$((index + 1))p" "$QUEUE_FILE")
    echo "$url"
}

# Function to update the progress file
update_progress() {
    local index
    index=$(cat "$PROGRESS_FILE")
    echo $((index + 1)) > "$PROGRESS_FILE"
}

# Initialize the queue and progress files
initialize_files

# Prompt the user to add URLs to the queue
add_urls_to_queue

# Prompt the user to select allowed file extensions
select_allowed_extensions

# Loop through each URL in the queue
while true; do
    url=$(get_next_url)
    if [ -z "$url" ]; then
        echo "No more URLs to process."
        break
    fi

    # Remove special characters from the URL to create the folder name
    folder_name=$(echo "$url" | sed 's/[^a-zA-Z0-9]//g')

    # Create the folder
    mkdir -p "./$folder_name"

    # Run gospider with the provided URL and save output to the folder
    gospider --site "$url" --depth 0 --concurrent 5 --threads 2 --output "./$folder_name" --user-agent "web" --other-source --include-subs --sitemap --js

    # Get the first file within the folder
    input_file=$(find "./$folder_name" -type f | head -n 1)

    if [ -z "$input_file" ]; then
        echo "No files found in the folder."
        update_progress
        continue
    fi

    # Convert the file to a text format
    output_file="${input_file%.*}.txt"
    mv "$input_file" "$output_file"

    # Check if the input file exists
    if [[ ! -f "$output_file" ]]; then
        echo "Input file not found!"
        update_progress
        continue
    fi

    # Read the file and extract URLs
    while IFS= read -r line; do
        # Use regex to extract URLs
        if [[ $line =~ (https?|ftp)://[^\ ]+ ]]; then
            url="${BASH_REMATCH[0]}"
            # Check if the URL ends with an allowed file extension
            if grep -Eq "\.${url##*.}" "$EXTENSION_FILE"; then
                echo "Downloading $url"
                wget "$url"
            else
                echo "URL does not match allowed file types: $url"
            fi
        else
            echo "No URL found in line: $line"
        fi
    done < "$output_file"

    # Update the progress file
    update_progress
done
