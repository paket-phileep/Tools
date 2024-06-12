#!/bin/bash

# Function to extract URLs from files
extract_urls() {
    # Loop through each file provided as argument
    for file in "$@"; do
        # Check if the file exists
        if [ ! -f "$file" ]; then
            echo "File $file not found"
            exit 1
        fi

        # Use grep with a regular expression to find URLs
        # This regular expression matches common URL patterns
        # It may not cover all possible URL formats
        urls=$(grep -Eo '(http|https)?://[a-zA-Z0-9./?=_-]*' "$file")

        # Print the extracted URLs
        echo "$urls"
    done
}

# Call the function if the script is executed standalone
if [ "$0" = "$BASH_SOURCE" ]; then
    extract_urls "$@"
fi

# Function to apply color to text
# apply_color() {
#     local text="$1"
#     local color_name="$2"
#     local reset_code='\033[0m'

#     # Get the escape code for the specified color
#     local current_color=$(get_color_escape_code "$color_name")

#     # Print the text with the specified color
#     echo "${current_color}${text}${reset_code}"
# }

# Extracting the command line arguments

#* USAGE
# concatenated_urls=$(./extract_urls.sh ./import/*)
# echo "$concatenated_urls"

