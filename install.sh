#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
clear

echo "Welcome to the unipkg installer."
echo "the unipkg installer will place all of the unipkg files in the correct directories"
echo "you'll find the config in ~/.config/unipkg"
echo "you'll find all the scripts in ~/.local/share/unipkg"
echo ""

 if command -v sudo > /dev/null && command -v bash > /dev/null && command -v fzf > /dev/null ; then
    echo "dependency check passed"
else
    echo "dependency check failed, please ensure fzf, sudo and bash are installed"
    exit 1
fi
echo ""
echo "there are two pre-set configurations for managers available, stable and dev"
echo "stable contains only human-written, human-verified configurations"
echo "dev contains configurations that were made by using AI to pull from the official documentation"
echo ""
echo "please choose which file you want to use, do note that dev does offer broader support"
choice=""

# Loop until a valid choice is made
while [[ "$choice" != "stable" && "$choice" != "dev" ]]; do
    # Prompt the user for input
    read -p "Choose an option (stable/dev): " choice

    # Convert input to lowercase (optional, for case-insensitive matching)
    choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    # Check if the choice is invalid
    if [[ "$choice" != "stable" && "$choice" != "dev" ]]; then
        echo "Invalid choice. Please enter 'stable' or 'dev'."
    fi
done

if [ "$choice" == "dev" ]; then
    echo "installing dev managers.csv"
    rm -rf ~/.config/unipkg
    mkdir -p ~/.config/unipkg
    cp $SCRIPT_DIR/conf/managers-dev.csv ~/.config/unipkg/managers.csv
fi

if [ "$choice" == "stable" ]; then
    echo "installing stable managers.csv"
    rm -rf ~/.config/unipkg
    mkdir -p ~/.config/unipkg
    cp $SCRIPT_DIR/conf/managers-stable.csv ~/.config/unipkg/managers.csv
fi


echo "installing scripts"
rm -rf ~/.local/share/unipkg
mkdir -p ~/.local/share/unipkg
cp -r $SCRIPT_DIR/scripts/* ~/.local/share/unipkg

echo "making scripts executable"
sudo chmod -R a+x ~/.local/share/unipkg/*

echo "linking to /usr/bin"
sudo ln -sf /home/$(whoami)/.local/share/unipkg/unipkg-tui /usr/bin
sudo ln -sf /home/$(whoami)/.local/share/unipkg/unipkg-cli /usr/bin/unipkg

echo "running unipkg-generate"
bash -c ~/.local/share/unipkg/unipkg-generate

