#!/bin/bash

# # Define the function
function confirm_urls {
# ASCII art
    echo "  "
    echo '  Scanning will begin in:'
	 echo "  "
    # Countdown timer
    countdown_duration=5 # 5 seconds countdown


    while [ $countdown_duration -gt 0 ]; do
        echo "  $countdown_duration... "
        sleep 1
        ((countdown_duration--))
    done
    echo
    echo "	Scanning..."

    display_urls "url_queue.txt"

}


# Function to confirm URLs
display_urls() {
    while read -r url; do
	 colorizer.sh --text "  $url"
    done < "$1"
}

# Call the function with the provided file name
confirm_urls
