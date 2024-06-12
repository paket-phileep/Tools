#!/bin/bash

# Replace these variables with your GitHub username and repository name
USERNAME="sullemanhossam"
REPO="WebScratcher"

# GitHub API endpoint to get contributors
API_ENDPOINT="https://api.github.com/repos/${USERNAME}/${REPO}/contributors"

# Make a GET request to the API endpoint
response=$(curl -s "$API_ENDPOINT")

# Check if the request was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to retrieve contributors."
    exit 1
fi

# Parse the response and extract contributors' usernames
contributors=$(echo "$response" | grep -o '"login": "[^"]*' | cut -d'"' -f4)

# File containing quotes
quotes_file="./db/rapper_quotes.txt"

# Function to get a random quote
get_random_quote() {
    # Count the number of lines in the file
    total_lines=$(wc -l < "$quotes_file")
    # Generate a random number between 1 and the total number of lines
    random_line=$((RANDOM % total_lines + 1))
    # Extract the random line from the file
    sed "${random_line}q;d" "$quotes_file"
}

# Loop through each contributor
for contributor in $contributors; do
    # Get a random quote
    random_quote=$(get_random_quote)
    # Print the contributor and their random quote
     sh  ./tools/colorizer.sh --text " $contributor: $random_quote"
done