#!/bin/bash

# Check if a URL is passed as an argument
if [ -z "$1" ]; then
  read -p "Please enter the URL you would like convert to PDF: " url
else
  url=$1
fi

# Create a temporary user data directory for Chromium
temp_user_data_dir=$(mktemp -d -t chromium-XXXXXX)

# Run Chromium in headless mode to print the URL to a PDF, using the temporary user data directory
chromium --headless --disable-gpu --print-to-pdf="output.pdf" --user-data-dir="$temp_user_data_dir" "$url"

# Clean up the temporary user data directory
rm -rf "$temp_user_data_dir"
