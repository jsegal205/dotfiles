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

# asdf was rewritten from bash to go in 0.16 therefore there isn't a bash script
# to reference anymore:
# https://github.com/asdf-vm/asdf/releases/tag/v0.16.0
#
# this `if` block can be removed sometime in the future.
if command -v asdf >/dev/null; then
  ASDF_VERSION=$(asdf --version | sed 's/^v//')
  if [ "$(printf '0.16.0\n%s\n' "$ASDF_VERSION" | sort -V | head -n1)" != "0.16.0" ]; then
    . $(brew --prefix asdf)/libexec/asdf.sh
  fi
fi

# Zsh configs
PROMPT_EOL_MARK=''

# Application configs
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Custom alias
alias dadjoke="curl -H \"Accept: text/plain\" https://icanhazdadjoke.com/"

#   delete merged branches
alias dmb="git branch --merged | grep -Ev '(^\\*|main)' | xargs -n 1 git branch -d"

# Code things
export ERL_AFLAGS="-kernel shell_history enabled"
export GPG_TTY=$(tty)
