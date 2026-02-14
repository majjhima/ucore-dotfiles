#!/bin/sh

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Copy dotfiles
rsync -av "$SCRIPT_DIR/" "$HOME/"

# Initialize submodules
cd $HOME
git submodule update --init --recursive

# Create .gitconfig
cat << EOF > .gitconfig
[user]
    name = $(getent passwd $USER | cut -d ':' -f 5)
[include]
    path = .gitconfig-common
[credential]
    helper = cache --timeout=43200
[init]
    defaultBranch = main
EOF
