#!/bin/bash

# Input parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
    --direction) color="$2"; shift ;;
    --data) text="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done


# Function to convert comma-delimited string to array
delimit_to_array() {
    # Set the Internal Field Separator to comma
    IFS=','
    # Create an empty array to store the values
    local array=()
    # Loop through the comma-separated string
    for item in $data; do
        # Add each item to the array
        array+=("$item")
    done
    # Print the array elements
    echo "${array[@]}"
}

# Function to convert array to comma-delimited string
eliminate_to_string() {
    # Join array elements with comma
    local joined_string=$(IFS=,; echo "${data[*]}")
    # Print the joined string
    echo "$joined_string"
}

# Main script logic
if [ "$direction" == "deliminate" ]; then
    delimit_to_array
elif [ "$direction" == "eliminate" ]; then
    eliminate_to_string
else
    echo "Invalid direction. Please specify 'deliminate' or 'eliminate'."
fi
