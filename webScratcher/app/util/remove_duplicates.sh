#!/bin/bash

# Function to remove duplicates from an array of strings
remove_duplicates() {
    # Loop through each element provided as argument
    for element in "$@"; do
        # Check if the element is already in the array
        if [[ ! " ${unique_elements[@]} " =~ " $element " ]]; then
            # If not, add it to the array
            unique_elements+=("$element")
        fi
    done

    # Print the unique elements
    echo "${unique_elements[@]}"
}

# Call the function if the script is executed standalone
if [ "$0" = "$BASH_SOURCE" ]; then
    remove_duplicates "$@"
fi

#* USAGE
# unique_elements=$(./remove_duplicates.sh "string1" "string2" "string1")
# echo "$unique_elements"

