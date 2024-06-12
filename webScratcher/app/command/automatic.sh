    #!/bin/bash



    QUEUE_FILE="../app/db/queue_file.txt"
    PROGRESS_FILE="../app/db/url_progress.txt"
    # Function to initialize the queue and progress files
    initialize_files() {
        concatenated_urls=$(../app/util/extract_domains.sh ../import/*)
        # Create or clear the queue and progress files
        : >"$QUEUE_FILE"
        echo 0 >"$PROGRESS_FILE"
    }

    #?  Clean up the old temp files before anything gets saved to them
    initialize_files

    #?  Firstly begin the dialogue and gain the files / data
    echo " "
    echo " "
    echo " "
    ../app/img/ascii.cash_decal.sh
    echo " "
    echo " "
    read -p "  Enter the URL(s) to crawl (single URL or comma-separated), or press ENTER to use URLs from files: " url_input
    # Prompt the user 
    echo " "
    echo " "
    echo "  Gathering data... Just like a detective collecting clues, but with fewer magnifying glasses...."
    echo " "
    echo " "

    process_data() {
        #!  Load URLs from files if no input provided
        if [ -z "$url_input" ]; then
            concatenated_urls=$(../app/util/extract_domains.sh ../import/*)
        else
        #!  Get the urls from user input optionally
            concatenated_urls=$(../app/util/comma_array.sh --direction "eliminate" --data "$url_input")
        fi

        #! Redefine the variable we used to store the concatenated URLs without any bs only URLS; SWAG
        concatenated_urls=$(../app/util/remove_duplicates.sh "$concatenated_urls")

        for url in $concatenated_urls; do
            # Check if the url exists
            if [ ! -f "$url" ]; then
                sh ../app/tools/colorizer.sh --text " $url"
            fi
        done
    }

    #?  Get processing the passed in data ready for work
    process_data

    read -p "Enter 'yes' to proceed with this selection or 'no' to cancel: " user_response
    if [ "$user_response" = "yes" ]; then
        echo "Proceeding with the URLs gathered from the import folder."
        # Add your logic here to proceed with the gathered URLs
    elif [ "$user_response" = "no" ]; then
        echo "Operation canceled."
        # Add your logic here if the user chooses not to proceed
    else
        echo "Invalid input. Please enter 'yes' or 'no'."
    fi


    # add to que 
