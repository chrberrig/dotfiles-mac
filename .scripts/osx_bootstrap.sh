#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
# brew tap homebrew/dupes #(decrepited) 
brew install coreutils
brew install gnu-sed
brew install gnu-tar
brew install gnu-indent
brew install gnu-which
brew install grep

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    git
    wget
    python
    neomutt
    ranger
    tor
    tree
    xpdf
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

# You will find a sample Tor configuration file at /usr/local/etc/tor/torrc.sample. Remove the .sample extension to make it effective. https://2019.www.torproject.org/docs/tor-doc-osx.html.en

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
# No longer necessary for cask...
# brew install caskroom/cask/brew-cask

CASKS=(
    mactex
    firefox
    xquartz
    vlc
    tor-browser
    calibre
    protonmail-bridge
    protonvpn
)
#    zotero
#    inkscape (for some reason, this dont work...)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

# cd && cd Downloads 
# wget https://github.com/retorquere/zotero-better-bibtex/releases/download/v5.1.63/zotero-better-bibtex-5.1.63.xpi
# wget https://protonmail.com/download/Bridge-Installer.dmg
# wget https://protonvpn.com/download/ProtonVPN.dmg

# echo "Installing fonts..."
# brew tap caskroom/fonts
# FONTS=(
#     font-inconsolidata
#     font-roboto
#     font-clear-sans
# )
# brew cask install ${FONTS[@]}
# 
# echo "Installing Python packages..."
# PYTHON_PACKAGES=(
#     ipython
#     virtualenv
#     virtualenvwrapper
# )
# sudo pip install ${PYTHON_PACKAGES[@]}
# 
# echo "Installing Ruby gems"
# RUBY_GEMS=(
#     bundler
#     filewatcher
#     cocoapods
# )
# sudo gem install ${RUBY_GEMS[@]}
# 
# echo "Installing global npm packages..."
# npm install marked -g
# 
# # Use commmends of this type to add tex packages to TeXLive distro.
# sudo tlmgr install multirow
# 
# 
# echo "Configuring OSX..."
# 
# # Set fast key repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 0
# 
# # Require password as soon as screensaver or sleep mode starts
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0
# 
# # Show filename extensions by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# 
# # Enable tap-to-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# 
# # Disable "natural" scroll
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# 
# echo "Creating folder structure..."
# [[ ! -d Wiki ]] && mkdir Wiki
# [[ ! -d Workspace ]] && mkdir Workspace

echo "Bootstrapping complete"
