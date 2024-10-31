# Migrated from old mac .zshrc
export PATH=/opt/homebrew/Cellar/zsh/5.9/bin/:$PATH

VSCODE=code-insiders

# InfluxDB token for influxdb.chanmyae.me to be used with mac telegraf
export INFLUX_TOKEN=IQHfcNlaDJrFNIfFr1P0L8RElgG6tEFhrxcKYOm6MQfiSpMNegy6vv0RWKvEGihuQZHB9y1y6hHhwLI0nMp3RA==

alias nvim="$HOME/bin/nvim-macos-arm64/bin/nvim"

# Path exports for mysql bin and lib
export PATH="$PATH:/usr/local/mysql/bin"
# export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH" # old mysql 5.5
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.7/lib:$DYLD_LIBRARY_PATH"
export PATH="$PATH:/usr/local/opt/mysql@5.7/bin"

# Exports for imagemagick 6.9
export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"
export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/lib/pkgconfig"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="$PATH:/opt/podman/bin"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# set up colima to standin as docker host
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
alias mbrew=/opt/homebrew/bin/brew
export PATH="$PATH:/opt/homebrew/bin"
export HOMEBREW_NO_AUTO_UPDATE=1

# Set up golang
export PATH="$PATH:/usr/local/go/bin"
