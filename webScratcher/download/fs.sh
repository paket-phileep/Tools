# #!/bin/bash

res_dir="../../post"

producer=""
api_key=""

# Loop through the arguments to find the producer and api key
for ((i=2; i<=$#; i++)); do
    if [ "${!i}" == "--producer" ] && ((i+1 <= $#)); then
        producer="${!((i+1))}"
    elif [ "${!i}" == "--apikey" ] && ((i+1 <= $#)); then
        api_key="${!((i+1))}"
    fi
done

# If producer is not specified or invalid, prompt the user to choose one
if [ -z "$producer" ] || [ "$producer" -gt 4 ] || [ "$producer" -lt 1 ]; then
    echo "Available producers:"
    echo "1. ollama"
    echo "2. groq"
    echo "3. openai"
    echo "4. claude"

    read -p "Enter the number corresponding to the desired producer: " producer_num

    case $producer_num in
        1) producer="ollama";;
        2) producer="groq";;
        3) producer="openai";;
        4) producer="claude";;
        *) echo "Invalid selection"; exit 1;;
    esac
fi

# If API key is required for the selected producer and not provided, prompt the user to enter it
if [ "$producer" == "groq" ] || [ "$producer" == "openai" ] || [ "$producer" == "claude" ]; then
    if [ -z "$api_key" ]; then
        read -p "Please enter your $producer API key: " api_key
    fi
fi

# Now you have the res_dir, producer, and API key (if required), you can proceed with your application logic
# For demonstration, let's print them
echo "Resource Directory: $res_dir"
echo "Producer: $producer"
echo "API Key: $api_key"

cd not-llama-fs || exit

python3 -m venv env

# Path to the virtual environment
venv_path="env/bin/activate"

# Check if the virtual environment activation script exists
if [ -f "$venv_path" ]; then
	# Activate the virtual environment
	source "$venv_path"
	echo "Virtual environment activated."
else
	echo "Virtual environment not found at: $venv_path"
fi

pip install -r requirements.txt
# pip install --no-require-hashes -r requirements.txt
pip install llama-index

# Call your Python script with the provided parameters


# Get the absolute path of the directory referenced by res_dir
abs_res_dir=$(realpath "$res_dir")

# Ask the user if they want the directory to be sorted
read -p "Do you want to sort the directory $abs_res_dir? [yes/no]: " sort_confirm

# Check user's response
if [ "$sort_confirm" == "yes" ]; then
  # Reassign res_dir to the abs directory
    res_dir="$abs_res_dir"
# Continue with the script execution using res_dir
  python3 -m app demo "$res_dir" --producer "$producer" --apikey "$api_key"
else
# retry the application
    sh fs.sh
fi
