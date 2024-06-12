#!/bin/bash

# Function to extract URLs from files
correct_urls() {
    # Loop through each file provided as argument
    for url in "$@"; do
        # Check if the file exists
        if [ ! -f "$url" ]; then
            echo "URL $url not supplied"
            exit 1
        fi

        # Add www if not present
        if [[ ! $url =~ ^https://www\. ]]; then
            url=${url/https:\/\//https:\/\/www.}
        fi

        # Remove trailing slash if present
        if [[ $url == */ ]]; then
            url=${url%/}
        fi

        # Print the extracted URLs
        echo "$urls"
    done
}

# Call the function if the script is executed standalone
if [ "$0" = "$BASH_SOURCE" ]; then
    correct_urls "$@"
fi

#* USAGE
# concatenated_urls=$(./extract_urls.sh ./import/*)
# echo "$concatenated_urls"




