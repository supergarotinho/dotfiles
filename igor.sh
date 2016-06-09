#!/usr/bin/env bash
mkdir ~/Projects

git config --global user.email "igor@borges.me"
git config --global user.name "Igor1201"
git config --global user.signingkey "7AD24624"
git config --global core.excludesfile "~/.gitignore"

curl https://install.meteor.com/ | sh

brew cask install iterm2
brew cask install google-chrome
brew cask install telegram
brew cask install spectacle
brew cask install xbox360-controller-driver
brew cask install utorrent
brew cask install android-studio
