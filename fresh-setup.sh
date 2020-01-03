# !/bin/bash

# will likely need permissions to run
# cd path/to/file
# chmod +x fresh-setup.sh

echo "=== Installing xcode cli ==="
xcode-select --install

echo "=== Setting up OSX defaults ==="
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

# kill things to take immediate effect
killall SystemUIServer
killall Finder

if test ! $(which brew); then
  echo "=== Installing homebrew ==="
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

brew cleanup

brew install zsh

echo "=== Installing Oh My Zsh ==="
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

PACKAGES=(
  asdf
  coreutils
  git
  gpg
  mysql
  npm
  openssl
  yarn
)

echo "=== Installing brew packages ==="
brew install ${PACKAGES[@]}

echo "=== ZSH Syntax Highlighting ==="
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

CASKS=(
  firefox
  google-chrome
  iterm2
  postman
  slack
  visual-studio-code
)

echo "=== Installing brew casks ==="
brew cask install ${CASKS[@]}

brew cleanup

ASDF_PLUGINS=(
  "nodejs https://github.com/asdf-vm/asdf-nodejs.git"
  "python"
  "ruby https://github.com/asdf-vm/asdf-ruby.git"
)

echo "=== Installing asdf plugins ==="
for asdf_plugin in "${ASDF_PLUGINS[@]}"; do
  asdf plugin-add $asdf_plugin
done

# need to update the keyring per nodejs asdf plugin
# https://github.com/asdf-vm/asdf-nodejs#install
echo "=== Setting keyring for asdf NodeJS ==="
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

ASDF_VERSIONS=(
  "nodejs 12.12.0"
  "python 3.8.0"
  "ruby 2.6.3"
)

echo "=== Installing asdf versions ==="
for asdf_version in "${ASDF_VERSIONS[@]}"; do
  asdf install $asdf_version
  asdf global $asdf_version
done

echo "=== Copying rc files ==="
RC_FILES=(
  .gemrc
  .vimrc
  .zshrc
)
for file in "${RC_FILES[@]}"; do
  cp $file ~/$file
done

# copy vscode settings file to code directory
cp settings.json $HOME/Library/Application\ Support/Code/User/settings.json

echo "=== Remember to run the following command after all is said and done ==="
echo "source ~/.zshrc"
