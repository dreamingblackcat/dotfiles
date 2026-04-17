#!/bin/sh
# run_once_install-chezmoi.sh
# Bootstraps chezmoi itself. This script runs once on first apply.
# On subsequent machines, run:
#   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dreamingblackcat

set -e

if command -v chezmoi > /dev/null 2>&1; then
    echo "chezmoi already installed, skipping."
    exit 0
fi

echo "Installing chezmoi..."
sh -c "$(curl -fsLS get.chezmoi.io)"
echo "chezmoi installed successfully."
