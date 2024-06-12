#!/bin/bash

QUEUE_FILE="queue_file.txt"
PROGRESS_FILE="url_progress.txt"
UNIQUE_URLS_FILE="unique_urls.txt"


# Function to add URLs to the queue
add_urls_to_queue() {
    echo "$url_input" > "$UNIQUE_URLS_FILE"

    # Clean up the URLs, remove duplicates, and add them to the queue
    awk '!seen[$0]++' "$UNIQUE_URLS_FILE" > "$QUEUE_FILE"
}

# Function to get the next URL from the queue
get_next_url() {
    local index
    index=$(<"$PROGRESS_FILE")
    sed -n "$((index + 1))p" "$QUEUE_FILE"
}

# Function to update the progress file
update_progress() {
    local index
    index=$(<"$PROGRESS_FILE")
    echo $((index + 1)) > "$PROGRESS_FILE"
}

# Prompt the user to add URLs to the queue
add_urls_to_queue

# Ask for confirmation
read -p "Do you want to proceed with scanning these URLs? (yes/no): " confirmation
if [ "$confirmation" != "yes" ]; then
    echo "Scan aborted."
    exit 1
fi

# Check if resuming scan from a specific index
index=$(<"$PROGRESS_FILE")
if [ "$index" -gt 0 ]; then
    echo "Resuming scan from index $index..."
else
    echo "Starting scan..."
fi

# Loop through each URL in the queue from the specified index
while true; do
    url=$(get_next_url)
    if [ -z "$url" ]; then
        echo "No more URLs to process."
        break
    fi

    # Process the URL
    echo "Processing $url..."

    # Update progress
    update_progress
done
