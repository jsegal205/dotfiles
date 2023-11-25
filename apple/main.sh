# !/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up OSX defaults"

##############################################

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

log "Remove default programs that are bundled with OSX"
sudo rm -rf /Applications/iMovie.app
sudo rm -rf /Applications/GarageBand.app

log "Creating default folders I always use"
mkdir -p ~/personal
mkdir -p ~/work
mkdir -p ~/Desktop/slack-downloads
