# # #!/bin/bash

# # # Function to check if a command exists
# # command_exists() {
# #     command -v "$1" &> /dev/null
# # }

# # # Check the operating system
# # OS=$(uname -s)
# # case "$OS" in
# #     Linux*)
# #         PACKAGE_MANAGER="linuxbrew"
# #         ;;
# #     Darwin*)
# #         PACKAGE_MANAGER="brew"
# #         ;;
# #     *)
# #         echo "Unsupported operating system: $OS"
# #         exit 1
# #         ;;
# # esac

# # # Install Homebrew or Linuxbrew if not already installed
# # if ! command_exists "$PACKAGE_MANAGER"; then
# #     echo "$PACKAGE_MANAGER not found. Installing $PACKAGE_MANAGER..."
# #     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# # else
# #     echo "$PACKAGE_MANAGER is already installed."
# # fi

# # # Add Homebrew or Linuxbrew to PATH
# # eval $("$(command -v "$PACKAGE_MANAGER")" shellenv)

# # # Function to install packages based on the package manager
# # install_package() {
# #     if ! command_exists "$1"; then
# #         echo "$1 not found. Installing $1..."
# #         "$PACKAGE_MANAGER" install "$1"
# #     else
# #         echo "$1 is already installed."
# #     fi
# # }

# # # Install required tools
# # echo "Installing required tools..."
# # install_package poppler
# # install_package imagemagick
# # install_package tesseract
# # install_package jbig2enc

# # # Install recommended tools
# # echo "Installing recommended tools..."
# # install_package aspell
# # install_package parallel

# # # Install Ruby Gem pdfbeads
# # echo "Installing pdfbeads..."
# # gem install pdfbeads --user-install

# # # Install other tools based on the operating system
# # case "$OS" in
# #     Linux*)
# #         echo "Installing tools for Linux..."
# #         install_package curl
# #         install_package wkhtmltopdf
# #         install_package chromium
# #         ;;
# #     Darwin*)
# #         echo "Installing tools for macOS..."
# #         install_package wkhtmltopdf
# #         install_package chromium
# #         ;;
# #     *)
# #         echo "Unsupported operating system: $OS"
# #         exit 1
# #         ;;
# # esac

# # # Install ScanTailor Universal from source
# # echo "Installing ScanTailor Universal..."
# # if ! command_exists scantailor-universal; then
# #     echo "Clone ScanTailor Universal repository..."
# #     git clone https://github.com/trufanov-nok/scantailor-universal.git
# #     cd scantailor-universal

# #     echo "Install dependencies for ScanTailor Universal..."
# #     install_package qt@5 # Install Qt5 using Homebrew or Linuxbrew
# #     "$PACKAGE_MANAGER" link qt@5 --force # For macOS only
# #     install_package cmake

# #     echo "Building ScanTailor Universal..."
# #     mkdir build
# #     cd build
# #     cmake ..
# #     make

# #     echo "Installing ScanTailor Universal..."
# #     sudo make install
# # else
# #     echo "ScanTailor Universal is already installed."
# # fi

# # echo "All tools have been installed successfully."

# #!/bin/bash

# # Function to check if a command exists
# command_exists() {
#     command -v "$1" &> /dev/null
# }

# # Check the operating system
# OS=$(uname -s)
# case "$OS" in
#     Linux*)
#         PACKAGE_MANAGER="linuxbrew"
#         ;;
#     Darwin*)
#         PACKAGE_MANAGER="brew"
#         ;;
#     *)
#         echo "Unsupported operating system: $OS"
#         exit 1
#         ;;
# esac

# # Install Homebrew or Linuxbrew if not already installed
# if ! command_exists "$PACKAGE_MANAGER"; then
#     echo "$PACKAGE_MANAGER not found. Installing $PACKAGE_MANAGER..."
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# else
#     echo "$PACKAGE_MANAGER is already installed."
# fi

# # Add Homebrew or Linuxbrew to PATH
# eval $("$(command -v "$PACKAGE_MANAGER")" shellenv)

# # Function to install packages based on the package manager
# install_package() {
#     if ! command_exists "$1"; then
#         echo "$1 not found. Installing $1..."
#         "$PACKAGE_MANAGER" install "$1"
#     else
#         echo "$1 is already installed."
#     fi
# }

# # Install required tools
# echo "Installing required tools..."
# install_package poppler
# install_package imagemagick
# install_package tesseract
# install_package jbig2enc

# # Install recommended tools
# echo "Installing recommended tools..."
# install_package aspell
# install_package parallel

# # Install Ruby Gem pdfbeads
# echo "Installing pdfbeads..."
# gem install ttfunk -v 1.7.0
# gem install pdfbeads --user-install

# # Add user Ruby gem directory to PATH
# export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# # Install other tools based on the operating system
# case "$OS" in
#     Linux*)
#         echo "Installing tools for Linux..."
#         install_package curl
#         install_package wkhtmltopdf
#         install_package chromium
#         install_package exiv2
#         ;;
#     Darwin*)
#         echo "Installing tools for macOS..."
#         install_package wkhtmltopdf
#         install_package chromium
#         brew install exiv2
#         ;;
#     *)
#         echo "Unsupported operating system: $OS"
#         exit 1
#         ;;
# esac

# # Install ScanTailor Universal from source
# echo "Installing ScanTailor Universal..."
# if ! command_exists scantailor-universal; then
#     echo "Clone ScanTailor Universal repository..."
#     git clone https://github.com/trufanov-nok/scantailor-universal.git
#     cd scantailor-universal

#     echo "Install dependencies for ScanTailor Universal..."
#     install_package qt@5 # Install Qt5 using Homebrew or Linuxbrew
#     "$PACKAGE_MANAGER" link qt@5 --force # For macOS only
#     install_package cmake

#     echo "Building ScanTailor Universal..."
#     mkdir -p build
#     cd build
#     cmake ..
#     make

#     echo "Installing ScanTailor Universal..."
#     sudo make install
# else
#     echo "ScanTailor Universal is already installed."
# fi

# echo "All tools have been installed successfully."

#!/bin/bash

ollama pull llama3
ollama pull llava

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check the operating system
OS=$(uname -s)
case "$OS" in
    Linux*)
        PACKAGE_MANAGER="linuxbrew"
        ;;
    Darwin*)
        PACKAGE_MANAGER="brew"
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

# Install Homebrew or Linuxbrew if not already installed
if ! command_exists "$PACKAGE_MANAGER"; then
    echo "$PACKAGE_MANAGER not found. Installing $PACKAGE_MANAGER..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "$PACKAGE_MANAGER is already installed."
fi

# Add Homebrew or Linuxbrew to PATH
eval $("$(command -v "$PACKAGE_MANAGER")" shellenv)

# Function to install packages based on the package manager
install_package() {
    if ! command_exists "$1"; then
        echo "$1 not found. Installing $1..."
        "$PACKAGE_MANAGER" install "$1"
    else
        echo "$1 is already installed."
    fi
}

# Install required tools
echo "Installing required tools..."
install_package poppler
install_package imagemagick
install_package tesseract
install_package jbig2enc

# Install recommended tools
echo "Installing recommended tools..."
install_package aspell
install_package parallel

# Install Ruby Gem pdfbeads
echo "Installing pdfbeads locally..."
sudo gem install rmagick -v 5.5.0
sudo gem install --user-install ttfunk -v 1.7.0
sudo gem install --user-install pdfbeads

# Add user Ruby gem directory to PATH
sudo export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# Install other tools based on the operating system
case "$OS" in
    Linux*)
        echo "Installing tools for Linux..."
        install_package curl
        install_package wkhtmltopdf
        install_package chromium
        install_package exiv2
        ;;
    Darwin*)
        echo "Installing tools for macOS..."
        install_package wkhtmltopdf
        install_package chromium
        brew install exiv2
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

# Install ScanTailor Universal from source
echo "Installing ScanTailor Universal..."
if ! command_exists scantailor-universal; then
    echo "Clone ScanTailor Universal repository..."
    git clone https://github.com/trufanov-nok/scantailor-universal.git
    cd scantailor-universal

    echo "Install dependencies for ScanTailor Universal..."
    install_package qt@5 # Install Qt5 using Homebrew or Linuxbrew
    "$PACKAGE_MANAGER" link qt@5 --force # For macOS only
    install_package cmake

    echo "Building ScanTailor Universal..."
    mkdir -p build
    cd build
    cmake ..
    make

    echo "Installing ScanTailor Universal..."
    sudo make install
else
    echo "ScanTailor Universal is already installed."
fi

echo "All tools have been installed successfully."
