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
  pnpm
  redis-cli
  vscode
  zsh-syntax-highlighting
)

# User configuration
export PATH="$HOME/.node/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# Homebrew path
export PATH="$(brew --prefix)/bin:$PATH"

# asdf configs
export PATH=~/.asdf/shims:$PATH
. $(brew --prefix asdf)/libexec/asdf.sh

# Zsh configs
PROMPT_EOL_MARK=''

# Application configs
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Custom alias
alias dadjoke="curl -H \"Accept: text/plain\" https://icanhazdadjoke.com/"

#   delete merged branches
alias dmb="git branch --merged | grep -Ev '(^\\*|main)\" | xargs -n 1 git branch -d"

# Code things
export ERL_AFLAGS="-kernel shell_history enabled"
