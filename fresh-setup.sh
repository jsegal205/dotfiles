# !/usr/bin/env bash

set -e

# will likely need permissions to run
# cd path/to/file
# chmod +x fresh-setup.sh

log () {
  echo
  echo "[$(date +%F\ %H:%M:%S)]"
  echo "=== $1 ==="
}

if [ -d "$(xcode-select -p)" ]; then
  log "xcode installed, skipping"
else
  log "Installing xcode cli"
  xcode-select --install
fi

log "Setting up OSX defaults"
# create dir and set default location for screenshots
mkdir -p ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# set clock to 24 hour with day of the week (ie 'Mon Jan 1 23:59:59')
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm:ss'

# enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Remove all the things from the Dock
defaults delete com.apple.dock persistent-apps; killall Dock

# Set save dialog always expanded
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Set minimize animation to scale
defaults write com.apple.dock mineffect -string scale

# kill things to take immediate effect
killall SystemUIServer
killall Finder
killall Dock

if test ! $(which brew); then
  log "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  log " # Set  PATH, MANPATH, etc., for Homebrew."
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/jimsegal/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

log "Updating Brew"
brew update
brew cleanup

log "Installing Zsh"
brew install zsh

if test ! $(which asdf); then
  log "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

PACKAGES=(
  asdf
  autoconf
  coreutils
  fop
  git
  gpg
  libxslt
  mas
  npm
  openssl@1.1
  postgresql@14
  wxwidgets
  yarn
)

log "Installing brew packages"
brew install ${PACKAGES[@]}

SERVICES=(
  postgresql@14
)
log "Starting brew services"
brew services start ${SERVICES[@]}

log "ZSH Syntax Highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

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
brew install --cask --no-quarantine ${CASKS[@]}

brew cleanup

ASDF_PLUGINS=(
  "erlang https://github.com/asdf-vm/asdf-erlang.git"
  "elixir https://github.com/asdf-vm/asdf-elixir.git"
  "nodejs https://github.com/asdf-vm/asdf-nodejs.git"
  "python"
)

log "Installing asdf plugins"
for asdf_plugin in "${ASDF_PLUGINS[@]}"; do
  asdf plugin-add $asdf_plugin
done

ASDF_VERSIONS=(
  "elixir 1.15.6-otp-26"
  "erlang 26"
  "nodejs 18.11.0"
  "python 3.11.5"
)

log "Installing asdf versions"
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl@1.1)"
for asdf_version in "${ASDF_VERSIONS[@]}"; do
  asdf install $asdf_version
  asdf global $asdf_version
done

log "Copying rc files"
RC_FILES=(
  .vimrc
  .zshrc
)
for file in "${RC_FILES[@]}"; do
  cp $file ~/$file
done

if [[ $(arch) == 'arm64' ]]; then
  log "Adding Apple Silicon brew path to rc file"

  echo \\n\# Apple silicon homebrew path >> ~/.zshrc
  echo export PATH=\"/opt/homebrew/bin:\$PATH\" >> ~/.zshrc
else
  log "Adding Apple intel brew path to rc file"
  echo \\n\# Apple intel homebrew path >> ~/.zshrc
  echo export PATH=\"/usr/local/bin:\$PATH\" >> ~/.zshrc
fi

log "Copying VS Code settings"
cp ./settings.json $HOME/Library/Application\ Support/Code/User/settings.json

log "Installing Powerline Fonts"
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

log "Overwriting amuse zsh theme"
cp -rf ./amuse.zsh-theme $ZSH/themes/amuse.zsh-theme

# should fix compdef errors like:
# ` compdef: unknown command or service: rails `
rm -f ~/.zcompdump*; compinit

log "Remove default programs that are bundled with OSX"
sudo rm -rf /Applications/iMovie.app
sudo rm -rf /Applications/GarageBand.app

log_final () {
  echo "### $1"
}

log "Completed setup"
log_final "-------------------------"
log_final
log_final "Run the following commands next:"
log_final
log_final "\tsource ~/.zshrc"
log_final
log_final "Sign into Apple store then run the following command:"
log_final
log_final "\tmas lucky xcode"
log_final
log_final "-------------------------"
