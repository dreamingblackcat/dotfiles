#!/bin/bash

# Set environment variables
home="$HOME"
zsh_custom="${ZSH_CUSTOM:-"$home/.oh-my-zsh/custom"}"
temp_dir="$home/tmp"

# Function to install a package if the directory doesn't exist
install_unless_dir_exists() {
    local dir="$1"
    local package="$2"
    local install_cmd="$3"

    if [ -d "$dir" ]; then
        echo "$package already installed"
    else
        echo "Installing $package"
        mkdir -p "$temp_dir"
        cd "$temp_dir" || return
        eval "$install_cmd"
        cd - || return
        rm -rf "$temp_dir"
    fi
}

echo "Starting installation."

# Install Oh My Zsh
install_unless_dir_exists "$home/.oh-my-zsh" "Oh My Zsh" \
    "curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh"

# Install Powerlevel10k theme
install_unless_dir_exists "$zsh_custom/themes/powerlevel10k" "Powerlevel10k" \
    "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git powerlevel10k && mkdir -p $zsh_custom/themes/powerlevel10k && cp -R powerlevel10k/* $zsh_custom/themes/powerlevel10k/"

# Install required fonts
install_unless_dir_exists "$home/.local/share/fonts" "Required fonts" \
    "git clone --depth=1 https://github.com/romkatv/powerlevel10k-media.git powerlevel10k-media && cp -R powerlevel10k-media/MesloLGS\ NF\ Regular.ttf /usr/local/share/fonts/"

# Set the Powerlevel10k theme in .zshrc
if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$home/.zshrc"; then
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> "$home/.zshrc"
fi

# Install zsh-syntax-highlighting plugin
install_unless_dir_exists "$zsh_custom/plugins/zsh-syntax-highlighting" "zsh-syntax-highlighting" \
    "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting && mkdir -p $zsh_custom/plugins/zsh-syntax-highlighting && cp -R zsh-syntax-highlighting/* $zsh_custom/plugins/zsh-syntax-highlighting/"

# Install iterm-tab-color plugin
install_unless_dir_exists "$zsh_custom/plugins/iterm-tab-color" "iterm-tab-color" \
    "git clone https://github.com/bernardop/iterm-tab-color-oh-my-zsh.git iterm-tab-color && mkdir -p $zsh_custom/plugins/iterm-tab-color && cp -R iterm-tab-color/* $zsh_custom/plugins/iterm-tab-color/"

# Install zsh-autosuggestions plugin
install_unless_dir_exists "$zsh_custom/plugins/zsh-autosuggestions" "zsh-autosuggestions" \
    "git clone https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions && mkdir -p $zsh_custom/plugins/zsh-autosuggestions && cp -R zsh-autosuggestions/* $zsh_custom/plugins/zsh-autosuggestions/"
