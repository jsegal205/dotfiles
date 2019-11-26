# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  aws
  brew
  bundler
  docker
  docker-compose
  gem
  git
  npm
  pip
  rails
  redis-cli
  ruby
  vscode
  zsh-syntax-highlighting
)

# User configuration
export PATH="$HOME/.node/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/bin:$PATH"

. /usr/local/opt/asdf/asdf.sh
