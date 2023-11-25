# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="jsegal_theme"

plugins=(
  aws
  brew
  docker
  docker-compose
  elixir
  git
  npm
  pip
  redis-cli
  vscode
  zsh-syntax-highlighting
)

# User configuration
export PATH="$HOME/.node/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# Homebrew path
export PATH="$(brew --prefix)/bin:$PATH"

. /usr/local/opt/asdf/libexec/asdf.sh

# Zsh configs
PROMPT_EOL_MARK=''

# Application configs
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Custom alias
alias dadjoke="curl -H \"Accept: text/plain\" https://icanhazdadjoke.com/"

# Code things
export ERL_AFLAGS="-kernel shell_history enabled"
