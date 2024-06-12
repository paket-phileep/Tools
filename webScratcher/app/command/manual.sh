#!/bin/bash

# Function to log and display error messages
log_error() {
	echo "Error: $1" >&2
}


# Function to check if a file is a metadata file
is_metadata_file() {
    local filename=$(basename "$1")
    case "$filename" in
        .DS_Store|Thumbs.db|desktop.ini|*) return 0 ;;
        *) return 1 ;;
    esac
}

# ? USAGE sh main.sh --url=www.example.com
# Check if the URL is provided as a command-line argument
if [[ "$1" == "--url="* ]]; then
    # Extract the URL from the command-line argument
    url="${1#*=}"
else
    # Prompt the user to enter a URL or folder UUID
    read -p "Enter the URL or folder UUID of the previous scan you want to jumpstart: " url
fi


# Remove special characters from the URL to create the folder name
folder_name=$(echo "${url}" | sed 's/[^a-zA-Z0-9]//g')
echo "Folder name created: ${folder_name}"

# Find the first file within the folder, excluding metadata files
input_file=$(find "./$folder_name" -type f -exec basename {} \; | grep -v -E '(metadata|Thumbs.db|.DS_Store)' | head -n 1)
input_file="./$folder_name/$input_file"

# Check if the input file exists
if [[ ! -f ${input_file} ]]; then
	log_error "Input file not found!"
	exit 1
fi

echo "Input file found: ${input_file}"

# List of allowed file extensions
allowed_extensions="pdf|doc|docx|ppt|pptx|xls|xlsx"

# Read the file and extract URLs
while IFS= read -r line; do
	echo "Processing line: ${line}"
	# Use regex to extract URLs
	if [[ ${line} =~ (https?|ftp)://[^\ ]+ ]]; then
		url="${BASH_REMATCH[0]}"
		echo "URL found: ${url}"
		# Sort a unique location for the data
		output_dir="${folder_name}/RETRIEVED"
		# Check if the URL ends with an allowed file extension
		if [[ ${url} =~ \.(${allowed_extensions})$ ]]; then
			echo "Downloading ${url}"

			# Extract the filename from the URL
			filename=$(basename "${url}")

			# Remove the file extension to format the name
			name_without_extension="${filename%.*}"
			extension="${filename##*.}"

			# Replace hyphens and underscores with spaces, and capitalize each word
			formatted_name=$(echo "${name_without_extension}" | tr '-' ' ' | tr '_' ' ' | awk '{ for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2)) } 1')

			# Reconstruct the filename with the original extension
			formatted_filename="${formatted_name}.${extension}"
			echo "Formatted filename: ${formatted_filename}"

			# Let's give it its own place to live that doesn't conflict with the scans or other files
			# Construct the output file path
			output_file="${output_dir}/${formatted_filename}"
			echo "Output file path: ${output_file}"

			# Create the directory if it doesn't exist
			mkdir -p "${output_dir}"
			if [[ $? -ne 0 ]]; then
				log_error "Failed to create directory: ${output_dir}"
				exit 1
			fi

			# Download the file
			echo "Downloading ${url}"
			curl -o "${output_file}" --create-dirs --insecure --cipher DES-CBC3-SHA "${url}"
			if [[ $? -ne 0 ]]; then
				log_error "Failed to download ${url}"
                # Retry with more security 
                echo "Attempting to retry download ${url} with SSL"
                curl -o "${output_file}" --create-dirs --cipher DES-CBC3-SHA "${url}"
                if [[ $? -ne 0 ]]; then
                    log_error "Failed to download ${url}"
                       # Retry with more security 
                    echo "Attempting to retry download ${url} without cipher"
                    curl -o "${output_file}" --create-dirs "${url}"
                    if [[ $? -ne 0 ]]; then
                        log_error "Failed to download ${url}"
                        exit 1
                    fi
                    exit 1
                fi
				exit 1
			fi
		else
			echo "URL does not match allowed file types: ${url}"
		fi
	else
		echo "No URL found in line: ${line}"
	fi
done <"${input_file}"
