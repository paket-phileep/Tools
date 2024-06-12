#!/bin/bash



# Function to display main menu
show_menu() {
    echo "  +-------------------------------------+"
    echo "  |          Select an option:          |"
    echo "  +-------------------------------------+"
    echo "  | [1] Automatic site extraction       |"
    echo "  | [2] Manual                          |"
    echo "  | [3] Resume bulk                     |"
    echo "  +-------------------------------------+"
    echo ""
}

# Check the app for any current processes such as in the url progress or que file 
# maybe show that the progress is !% done ect 
show_resume() {
    echo "  +-------------------------------------+"
    echo "  |          Select an option:          |"
    echo "  +-------------------------------------+"
    echo "  | [1] Automatic site extraction       |"
    echo "  | [2] Manual                          |"
    echo "  | [3] Resume bulk                     |"
    echo "  +-------------------------------------+"
    echo ""
}


# Function to display main menu
show_tools_menu() {
    echo "  +-------------------------------------+"
    echo "  |          Select a tool:          |"
    echo "  +-------------------------------------+"
    echo "  | [1] Webpage to pdf        |"
    echo "  | [2] Manual                          |"
    echo "  | [3] Resume bulk                     |"
    echo "  +-------------------------------------+"
    echo ""
}

# Function to display post-extraction menu
show_post_extraction_menu() {
    echo "  +-------------------------------------------------------------------+"
    echo "  |        These options require an extracted dataset!                |"
    echo "  +-------------------------------------------------------------------+"
    echo "  | [4] Email snatcher                                                |"
    echo "  | [5] Article finder                                                |"
    echo "  +-------------------------------------------------------------------+"
    echo ""
}

# Function to handle exit
handle_exit() {
    echo ""
    echo  "\033[1;31m  You can press any key to exit...\033[0m"
    echo  "\033[1;31m  Exiting... Press Enter to continue...\033[0m"
    read
    exit
}

# Function to execute script based on selection
execute_script() {
    case $1 in
        1) ./service/automatic.sh ;;
        2) ./manual.sh ;;
        3) ./resume.sh ;;
        4) ./automatic_site_extraction_post.sh ;;
        5) ./manual_post.sh ;;
        6) ./resume_bulk_post.sh ;;
        9) echo "Exiting..."; exit ;;
        *) echo "Error: Invalid option. Press Enter to continue..."; read ;;
    esac
}


prompt(){
    echo "\033[1;32m  Enter your choice or E to exit: \033[0m\c" # Green colored prompt
}

# Main function
main() {
    while true; do
        # Show the header
       sh ./img/ascii.group.title.sh
        echo
        
        # Display cat decal and title side by side using temporary files
        cat_dec="$(mktemp)"
        title="$(mktemp)"
        printf "%-40s" "$(./img/ascii.cat_decal.sh)" > "$cat_dec"
        printf "%-40s" "$(./img/ascii.title.sh)" > "$title"
        paste -d "|" "$cat_dec" "$title"
        # rm "$cat_dec" "$title"
        echo ""
        echo ""   
           sh   ./img/contributors.sh
        echo ""   
        echo ""        
        menu="$(mktemp)"
        menu_post="$(mktemp)"
        printf "%-40s" "$(show_menu)" > "$menu"
        printf "%-40s" "$(show_post_extraction_menu)" > "$menu_post"
        # Show the menus
        paste -d "|" "$menu" "$menu_post"
        # show_post_extraction_menu
             echo ""        
        echo ""        

        # Prompt for user input and execute corresponding action
        prompt
        read choice
        case $choice in
            [1-9]) execute_script $choice ;;
            E) handle_exit $choice ;;
            *) echo "Error: Invalid option. Press Enter to continue..."; read;;
        esac
    done
}


# Start the script
main