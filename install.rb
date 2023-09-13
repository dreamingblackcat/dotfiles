#!/usr/bin/env ruby
$home = ENV['HOME']
$zsh_custom = ENV['ZSH_CUSTOM'] || "#{$home}/.oh-my-zsh/custom"

def install_unless_dir_exists(dir, package, &block)
  puts "#{package} already installed" and return if Dir.exist?(dir)

  if block_given?
    yield
  else
    puts "Replace me with actual #{package} installation command"
  end
end

puts "Starting installation."

install_unless_dir_exists("#{$home}/.oh-my-zsh", "Oh My Zsh") do
  puts "Installing Oh My Zsh"
  `curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh`
end

#[oh-my-zsh] plugin 'zsh-syntax-highlighting' not found
install_unless_dir_exists("#{$zsh_custom}/plugins/zsh-syntax-highlighting", "zsh-syntax-highlighting") do
  puts "Installing zsh-syntax-highlighting"
  `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting`
end
#[oh-my-zsh] plugin 'zprofile' not found
install_unless_dir_exists("#{$zsh_custom}/plugins/zprofile", "zprofile") do
  puts "Installing zprofile"
  `git clone https://github.com/qoomon/zprofile.git #{$zsh_custom}/plugins/zprofile`
end

#[oh-my-zsh] plugin 'iterm-tab-color' not found
install_unless_dir_exists("#{$zsh_custom}/plugins/iterm-tab-color", "iterm-tab-color") do
  puts "Installing iterm-tab-color"
  `git clone https://github.com/bernardop/iterm-tab-color-oh-my-zsh.git #{$zsh_custom}/plugins/iterm-tab-color`
end

#[oh-my-zsh] plugin 'zsh-autosuggestions' not found
install_unless_dir_exists("#{$zsh_custom}/plugins/zsh-autosuggestions", "zsh-autosuggestions") do
  puts "Installing zsh-syntax-highlighting"
  `git clone https://github.com/zsh-users/zsh-autosuggestions #{$zsh_custom}/plugins/zsh-autosuggestions`
end
