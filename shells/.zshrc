# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="spaceship"
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# FOR VSCODE zsh plugin
VSCODE=code

plugins=(
  git
  bundler
  dotenv
  macos
  rake
  ruby
  zsh-syntax-highlighting
  zprofile
  asdf
  iterm-tab-color
  docker
  docker-compose
  zsh-autosuggestions
  vscode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Iterm2 tab tile configuration
# Ref: https://gist.github.com/phette23/5270658
if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# My Personal aliases
alias reload!="source ~/.zshrc"
# alias code="/usr/local/bin/code-insiders"
alias c="clear"

export EDITOR='vim'
export BUNDLER_EDITOR="/usr/local/bin/code-insiders"
if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi

# Solargraph gem config for vscode ruby langauge server
export SOLARGRAPH_GLOBAL_CONFIG="$HOME/.solargraph.yml"

# Workcloud specific content that I've customized into shell.
[ -f "$HOME/.workcloud_config.sh" ] && source "$HOME/.workcloud_config.sh"

# Linux specific
[ -f "$HOME/.chan.linuxzshrc.sh" ] && source "$HOME/.chan.linuxzshrc.sh"
# MacOS specific
[ -f "$HOME/.chan.macoszshrc.sh" ] && source "$HOME/.chan.macoszshrc.sh"

### Ascender Aliases
function push {
  revised=$(ruby -e "puts \"`git log -1 --pretty=%B`\".chomp  + ' [ci skip]'")
  git commit --amend -m "$revised"
  git push origin $1 $2
}

function rubocop_modified() {
  git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop --config=.rubocop.yml
}

function rubocop_diff_with_stable() {
  git diff --name-only origin/stable | xargs ls -1 2>/dev/null | grep '\.rb$' | bundle exec rubocop --config=.rubocop.yml
}

function rsd(){
  echo "Starting rails server..."
  USE_S3=true USE_DELAYED_JOB=true BULLET=false bundle exec rails server $1 $2
}

function recent_git_branches() {
  git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
}

function git_copy_current_branch() {
  git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy
}
alias git_frequent_files="git log --format=format: --name-only | egrep -v '^$' | sort | uniq -c | sort -r"

alias gbre="recent_git_branches"
alias gbc="git_copy_current_branch"

alias jobs="USE_S3=TRUE rake jobs:work"
alias rsd="rsd"
alias rc="bundle exec rails console"
alias push="push"
alias build="git push origin $1"
alias rmg="RAILS_ENV=test bin/rails db:remigrate"
alias load_sanitized="RAILS_ENV=development bundle exec rake workcloud:db:load_sanitized"
alias  br="bin/rails"
# All rubocop related stuff
# TODO: currently modified them to use the legacy gem version for workcloud rails 3.2 ,
# fix it once we finished ruby upgrade
alias cop="~/.rvm/gems/ruby-2.2.8/gems/rubocop-0.58.2/exe/rubocop --config=.rubocop.yml"
alias copm="rubocop_modified"
alias copd="rubocop_diff_with_stable"

# Tmux related aliases
alias treload!="tmux source ~/.tmux.conf"

# eliases for docker based workcloud development
alias dkrc="docker-compose exec -T rails-app bundle exec rails c"

# aliases for exercism
alias exc="exercism"

# Exports for elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"


# SSH helpers
[ -f ~/.ssh/ssh_shell_helpers.sh ] && source ~/.ssh/ssh_shell_helpers.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Iterm2 shell intergration script
# source ~/.iterm2_shell_integration.zsh

[ -f "$HOME/.conda_shell_init.sh" ] && source "$HOME/.conda_shell_init.sh" # github auth token for gh cli
[ -f "$HOME/.githubtoken.sh" ] && source "$HOME/.githubtoken.sh" # github auth token for gh cli

# Add haskell environment to path
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env


if ! type "$zoxide" > /dev/null; then
  # install foobar here
  alias zo="zoxide"
fi

alias gcc="/usr/local/bin/gcc-4.9"
ulimit -S -n 10240

echo "Ctrl + U – delete from the cursor to the start of the line."
echo "Ctrl + K – delete from the cursor to the end of the line."
echo "Ctrl + W – delete from the cursor to the start of the preceding word."
echo "Alt + D – delete from the cursor to the end of the next word."
echo "Ctrl + L – clear the terminal."

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Add rustup toolchains to path
# for rust programming language
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"

eval "$(direnv hook zsh)"

export WORKON_HOME=~/.virtualenvs
[ -f "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"
alias ci="code-insiders"
alias z="zellij"

if command -v exa &> /dev/null; then
    alias ls="exa"
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
