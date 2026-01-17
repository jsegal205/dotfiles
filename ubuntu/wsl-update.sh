#!/bin/bash
# WSL2 Ubuntu Update Script
# Automatically updates and upgrades packages on session start

echo "=========================="
echo "Running system updates..."
echo "=========================="

# Update package lists
sudo apt update

# Upgrade installed packages
echo ""
echo "Upgrading packages..."
sudo apt upgrade -y

# Update oh-my-zsh
echo ""
echo "Updating oh-my-zsh..."
if [ -f "$HOME/.oh-my-zsh/tools/upgrade.sh" ]; then
    zsh "$HOME/.oh-my-zsh/tools/upgrade.sh"
else
    echo "oh-my-zsh not found, skipping..."
fi

echo ""
echo "=========================="
echo "System update complete!"
echo "=========================="
