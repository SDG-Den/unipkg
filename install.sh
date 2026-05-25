#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "installing base managers.csv"
rm -rf ~/.config/unipkg
mkdir -p ~/.config/unipkg
cp $SCRIPT_DIR/conf/managers.csv ~/.config/unipkg

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

