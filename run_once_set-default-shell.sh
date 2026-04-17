#!/bin/sh
# run_once_set-default-shell.sh
# Sets zsh as the default shell for the current user
# Runs once on first chezmoi apply

set -e

# Ensure zsh is installed
if ! command -v zsh > /dev/null 2>&1; then
    echo "zsh is not installed. Skipping default shell setup."
    exit 0
fi

ZSH_PATH=$(command -v zsh)

# Check if zsh is already the default shell
if [ "$SHELL" = "$ZSH_PATH" ]; then
    echo "zsh is already the default shell."
    exit 0
fi

echo "Setting zsh as default shell..."

# Use chsh to change the default shell
# For non-interactive mode, we use the -s flag with the path
if command -v chsh > /dev/null 2>&1; then
    if chsh -s "$ZSH_PATH" > /dev/null 2>&1; then
        echo "✓ Default shell set to zsh: $ZSH_PATH"
    else
        # Fallback: try with sudo if regular chsh fails
        if command -v sudo > /dev/null 2>&1; then
            sudo chsh -s "$ZSH_PATH" > /dev/null 2>&1 && \
                echo "✓ Default shell set to zsh (with sudo): $ZSH_PATH" || \
                echo "⚠ Could not change default shell. You may need to run: chsh -s $ZSH_PATH"
        else
            echo "⚠ Could not change default shell. You may need to run: chsh -s $ZSH_PATH"
        fi
    fi
else
    # Fallback for systems without chsh (rare)
    echo "⚠ chsh command not found. Manual setup required."
    echo "  Run this command: chsh -s $ZSH_PATH"
fi

echo "Note: You may need to log out and back in for the change to take effect."
