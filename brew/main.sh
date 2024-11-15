#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Homebrew and initial applications"

##############################################

if test ! "$(which brew)"; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  log "# Set  PATH, MANPATH, etc., for Homebrew."
  echo "eval '$(/opt/homebrew/bin/brew shellenv)'" >> /Users/jimsegal/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  log "Homebrew already installed, updating"
  brew update
fi

brew cleanup

log "Installing Zsh"
brew install zsh

if test ! "$(which asdf)"; then
  log "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

PACKAGES=(
  asdf
  autoconf
  coreutils
  colima
  fop
  git
  gpg
  libxslt
  mas
  node
  npm
  openssl@1.1
  pnpm
  postgresql@14
  wxwidgets
)

log "Installing brew packages"
brew install "${PACKAGES[@]}"

SERVICES=(
  postgresql@14
)
log "Starting brew services"
brew services start "${SERVICES[@]}"

CASKS=(
  firefox
  google-chrome
  postico
  postman
  slack
  spotify
  visual-studio-code
)

log "Installing brew casks"
brew install --cask --no-quarantine "${CASKS[@]}"

brew cleanup
