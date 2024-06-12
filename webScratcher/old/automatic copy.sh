
# QUEUE_FILE="queue_file.txt"
# PROGRESS_FILE="url_progress.txt"

# clean_prev(){
# 	rm -rf url_queue.txt
# 	rm -rf url_progress.txt
# }

# clean_prev

# # Function to initialize the queue and progress files
# initialize_files() {

#     [ ! -f "$QUEUE_FILE" ] && touch "$QUEUE_FILE"
#     [ ! -f "$PROGRESS_FILE" ] && echo 0 >"$PROGRESS_FILE"
# }

# # Function to add URLs to the queue
# add_urls_to_queue() {
#     echo " "
#     read -p "  Enter the URL(s) to crawl (single URL or comma-separated), or press ENTER to use URLs from files: " url_input
#     echo " "
#     echo " "
#     sh ascii.cash_decal.sh
#     echo " "
#     echo " "
#     echo "  Gathering data... Just like a detective collecting clues, but with fewer magnifying glasses...."
#     echo " "
#     echo " "

#     # Load URLs from files if no input provided
#     if [ -z "$url_input" ]; then
#         for file in ./import/*; do
#             while IFS= read -r line; do
#                 url_input+="${line// }," # Trim leading/trailing whitespace and add to input
#             done <"$file"
#         done
#         url_input=${url_input%,} # Remove trailing comma
#     fi

#     # Split the URLs into an array
#     IFS=',' read -ra urls <<<"$url_input"


# # Correct each URL and print it
# for url in "${urls[@]}"; do
#   corrected_url=$(correct_url $url)
#   echo $corrected_url >> unique_urls
# done

# for url in "${unique_urls[@]}"; do
#   echo "$url" >>"$QUEUE_FILE"
# done

# # Check if the array is empty
# if [ ${#unique_urls[@]} -eq 0 ]; then
#   echo "The urls array is now empty."
#   exit 1
# fi

# # Function to get the next URL from the queue
# get_next_url() {
#     local index
#     index=$(cat "$PROGRESS_FILE")
#     sed -n "$((index + 1))p" "$QUEUE_FILE"
# }

	# Load URLs from files if no input provided
	# if [ -z "$url_input" ]; then
	# 	cat ./import/* >>"$UNIQUE_URLS_FILE"
	# else
	# 	echo "$url_input" >"$UNIQUE_URLS_FILE"
	# fi

# # Function to update the progress file
# update_progress() {
#     local index
#     index=$(cat "$PROGRESS_FILE")
#     echo $((index + 1)) >"$PROGRESS_FILE"
# }

# # Initialize the queue and progress files
# initialize_files

# # Prompt the user to add URLs to the queue
# add_urls_to_queue

# sh ascii_and_countdown.sh

# # Ask for confirmation
# echo " "
# read -p "  Do you want to proceed with scanning these URLs? (yes/no): " confirmation
# if [ "$confirmation" != "yes" ]; then
#     echo "  Scan aborted."
#     exit 1
# fi

# echo "  Starting scan..."

# # Loop through each URL in the queue
# while true; do
#     url=$(get_next_url)
#     if [ -z "$url" ]; then
#         echo "No more URLs to process."
#         break
#     fi

#     # Remove special characters from the URL to create the folder name
#     folder_name=$(echo "$url" | sed 's/[^a-zA-Z0-9]//g')

#     # Run gospider with the provided URL and save output to the folder
#     gospider --site "$url" --depth 0 --concurrent 5 --threads 2 --output "./$folder_name" --user-agent "web" --other-source --include-subs --sitemap --js

#     # Get the first file within the folder
#     input_file=$(find "./$folder_name" -type f | head -n 1)

#     if [ -z "$input_file" ]; then
#         echo "No files found in the folder."
#         update_progress
#         continue
#     fi

#     # Check if the input file exists
#     if [[ ! -f $input_file ]]; then
#         echo "Input file not found!"
#         update_progress
#         continue
#     fi

#     # List of allowed file extensions
#     allowed_extensions="pdf|doc|docx|ppt|pptx|xls|xlsx"

#     # Read the file and extract URLs
#     while IFS= read -r line; do
#         # Use regex to extract URLs
#         if [[ $line =~ (https?|ftp)://[^\ ]+ ]]; then
#             url="${BASH_REMATCH[0]}"
#             # Check if the URL ends with an allowed file extension
#             if [[ $url =~ \.($allowed_extensions)$ ]]; then
#                 echo "Downloading $url"
#                 # sh main.sh --url="$url"
# 				 wget "$url"

#             else
#                 echo "URL does not match allowed file types: $url"
#             fi
#         else
#             echo "No URL found in line: $line"
#         fi
#     done <"$input_file"

#     # Update the progress file
#     update_progress
# done
    # UNIQUE_URLS_FILE="../db/unique_urls.txt"


    #!/bin/bash

    QUEUE_FILE="../app/db/queue_file.txt"
    PROGRESS_FILE="../app/db/url_progress.txt"
    # Function to initialize the queue and progress files
    initialize_files() {
        # Create or clear the queue and progress files
        : >"$QUEUE_FILE"
        echo 0 >"$PROGRESS_FILE"
    }

    #?  Clean up the old temp files before anything gets saved to them
    initialize_files


    #?  Firstly begin the dialoge and gain the files / data
    echo " "
	echo " "
	echo " "
      ../app/img/ascii.cash_decal.sh
	echo " "
	echo " "
	read -p "  Enter the URL(s) to crawl (single URL or comma-separated), or press ENTER to use URLs from files: " url_input
    # Promp the user 
	echo " "
	echo " "
	echo "  Gathering data... Just like a detective collecting clues, but with fewer magnifying glasses...."
	echo " "
	echo " "

    

    process_data(){
        #!  Load URLs from files if no input provided
        if [ -z "$url_input" ]; then
            concatenated_urls=$(../app/util/extract_domains.sh ../import/*)
        else
        #!  Get the urls from user input optionaly
            concatenated_urls=$(../app/util/comma_array.sh --direction "eliminate" --data "$url_input")
        fi

        #! Redefine the variable we used store the concatenated URLs without any bs only URLS; SWAG
        concatenated_urls=$(../app/util/remove_duplicates.sh "$concatenated_urls")

        # Use the extracted URLs
        # echo "Extracted URLs:"
        # echo "$concatenated_urls"
            for url in "$concatenated_urls"; do
        # Check if the file exists
            if [ ! -f "$url" ]; then
                echo "URL $url"
            fi
        }

    #?  Get processing the passed in data ready for work
    process_data

   # Function to add URLs to the queue
    # add_urls_to_queue() {

   
    # }

    # ? begin adding these urls to the que ready for extracting 
    # add_urls_to_queue


# # Write the concatenated URLs to the unique URLs file
# # echo "$concatenated_urls" > "$UNIQUE_URLS_FILE"

# 	# Load URLs from files if no input provided
# 	if [ -z "$url_input" ]; then
# 		cat ./import/* >>"$UNIQUE_URLS_FILE"
# 	else
# 		echo "$url_input" >"$UNIQUE_URLS_FILE"
# 	fi

# 	# Clean up the URLs, remove duplicates, and add them to the queue
# 	awk '!seen[$0]++' "$UNIQUE_URLS_FILE" >"$QUEUE_FILE"
# }

# # Function to get the next URL from the queue
# get_next_url() {
# 	local index
# 	index=$(<"$PROGRESS_FILE")
# 	sed -n "$((index + 1))p" "$QUEUE_FILE"
# }

# # Function to update the progress file
# update_progress() {
# 	local index
# 	index=$(<"$PROGRESS_FILE")
# 	echo $((index + 1)) >"$PROGRESS_FILE"
# }

# # Initialize the queue and progress files
# initialize_files

# # Prompt the user to add URLs to the queue
# add_urls_to_queue

# # Ask for confirmation
# read -p "Do you want to proceed with scanning these URLs? (yes/no): " confirmation
# if [ "$confirmation" != "yes" ]; then
# 	echo "Scan aborted."
# 	exit 1
# fi

# echo "Starting scan..."

# # Loop through each URL in the queue
# while true; do
# 	url=$(get_next_url)
# 	if [ -z "$url" ]; then
# 		echo "No more URLs to process."
# 		break
# 	fi

# 	# Process the URL
# 	echo "Processing $url..."

# 	# Update progress
# 	update_progress
# done
