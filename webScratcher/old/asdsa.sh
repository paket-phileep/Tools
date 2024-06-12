# #!/bin/bash

# # Extracting the command line arguments
# if [[ "$#" -eq 0 ]]; then
#     echo "No parameters provided. Usage: script.sh --urls 'URL_JSON'"
#     exit 1
# fi

# while [[ "$#" -gt 0 ]]; do
#     case $1 in
#         --urls) urls_json="$2"; shift 2 ;;
#         *) echo "Unknown parameter passed: $1"; exit 1 ;;
#     esac
# done

# # Using the extracted URLs value
# echo "Extracted URLs: $urls_json"

# # Validate the JSON
# if ! echo "$urls_json" | jq . > /dev/null 2>&1; then
#     echo "Invalid JSON passed: $urls_json"
#     exit 1
# fi

# # Assuming the URLs are in JSON array format, let's process them
# urls=$(echo "$urls_json" | jq -r '.[]')

# # Check if jq is installed
# if ! command -v jq &> /dev/null; then
#     echo "jq is required but it's not installed. Please install jq."
#     exit 1
# fi

# # Function to display ASCII art and start countdown before scanning URLs
# display_ascii_and_countdown() {
#     local urls=("$@")  # Accept array of URLs as arguments

#     # ASCII art
#     echo 'Scanning will begin in:'

#     # Countdown timer
#     countdown_duration=5 # 5 seconds countdown
#     while [ $countdown_duration -gt 0 ]; do
#         echo -n "$countdown_duration... "
#         sleep 1
#         ((countdown_duration--))
#     done
#     echo
#     echo "Scanning..."

#     # Print URLs for confirmation
#     echo "URLs to be scanned:"
#     for url in "${urls[@]}"; do
#         echo "$url"
#     done

#     # Ask for confirmation
#     read -p "Do you want to proceed with scanning these URLs? (yes/no): " confirmation
#     if [ "$confirmation" == "yes" ]; then
#         echo "Starting scan..."
#         # Initiating the scanning process...
#         # Add your code here to start scanning the URLs
#     else
#         echo "Scan aborted."
#         exit
#     fi
# }

# # Call the function with the extracted URLs
# display_ascii_and_countdown "${urls[@]}"

#!/bin/bash

# Define the function
function extract_urls {
    # Extract URLs from the argument passed to the function
    urls_arg="$1"
    
    # Replace commas with spaces to separate URLs
    urls=$(echo "$urls_arg" | tr ',' ' ')
    
    # Convert space-separated URLs to an array
    urls_array=($urls)
    
    # Print each URL in the array
    for url in "${urls_array[@]}"; do
        echo "$url"
    done
}

# Call the function with the provided argument
extract_urls "$1"