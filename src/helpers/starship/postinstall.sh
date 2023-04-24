#!/bin/bash

# Check if Bash is installed
if ! command -v bash &> /dev/null; then
    echo "Bash is not installed. Please install Bash before running this script."
    exit
fi

# Add or move the starship init bash command to the end of ~/.bashrc
if ! grep -q 'eval "\$\(starship init bash\)"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi

# Check if Fish shell is installed
if ! command -v fish &> /dev/null; then
    echo "Fish shell is not installed. Skipping Fish shell configuration."
    exit
fi

# Set the XDG_CONFIG_HOME environment variable if it is not set
: ${XDG_CONFIG_HOME:="$HOME/.config"}

# Add or move the starship init fish command to the end of $XDG_CONFIG_HOME/fish/config.fish
if ! grep -q 'starship init fish | source' "$XDG_CONFIG_HOME/fish/config.fish" 2>/dev/null; then
    echo 'starship init fish | source' >> "$XDG_CONFIG_HOME/fish/config.fish"
fi

echo "Starship configuration completed."
