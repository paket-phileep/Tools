#!/bin/bash

# Function to get the escape code for the specified color
get_color_escape_code() {
    local color_name=$1
    local escape_code

    case "$color_name" in
    "black")
        escape_code='\033[0;30m'
        ;;
    "red")
        escape_code='\033[0;31m'
        ;;
    "green")
        escape_code='\033[0;32m'
        ;;
    "yellow")
        escape_code='\033[0;33m'
        ;;
    "blue")
        escape_code='\033[0;34m'
        ;;
    "magenta")
        escape_code='\033[0;35m'
        ;;
    "cyan")
        escape_code='\033[0;36m'
        ;;
    "white")
        escape_code='\033[0;37m'
        ;;
    "bright_black")
        escape_code='\033[1;30m'
        ;;
    "bright_red")
        escape_code='\033[1;31m'
        ;;
    "bright_green")
        escape_code='\033[1;32m'
        ;;
    "bright_yellow")
        escape_code='\033[1;33m'
        ;;
    "bright_blue")
        escape_code='\033[1;34m'
        ;;
    "bright_magenta")
        escape_code='\033[1;35m'
        ;;
    "bright_cyan")
        escape_code='\033[1;36m'
        ;;
    "bright_white")
        escape_code='\033[1;37m'
        ;;
    *)
        # If color name is not recognized, choose a random color
        local colors=('red' 'green' 'yellow' 'blue' 'cyan' 'bright_red' 'bright_green' 'bright_yellow' 'bright_blue' 'bright_cyan')
        local random_index=$((RANDOM % ${#colors[@]}))
        local random_color=${colors[$random_index]}
        escape_code=$(get_color_escape_code "$random_color")
        ;;
    esac

    echo "$escape_code"
}

# Function to apply color to text
apply_color() {
    local text="$1"
    local color_name="$2"
    local reset_code='\033[0m'

    # Get the escape code for the specified color
    local current_color=$(get_color_escape_code "$color_name")

    # Print the text with the specified color
    echo "${current_color}${text}${reset_code}"
}

# Extracting the command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
    --color) color="$2"; shift ;;
    --text) text="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Apply color to the provided text
apply_color "$text" "$color"
