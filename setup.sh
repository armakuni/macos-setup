#!/bin/bash

BREW_BIN="/usr/local/bin/brew"
DOCKER_BIN="/Applications/Docker.app"
echo "Checking if Homebrew is installed..."
if [ ! -f $BREW_BIN ]; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebew installed"
else
    echo "homebrew already installed"
fi

echo "Checking if docker is installed..."
if [ ! -d $DOCKER_BIN ]; then
    echo "Installing Docker (this may take a few minutes)"
    if [ ! -f ~/Downloads/Docker.dmg ]; then
        curl -s https://download.docker.com/mac/stable/Docker.dmg -o ~/Downloads/Docker.dmg
    fi

    hdiutil attach -quiet -nobrowse ~/Downloads/Docker.dmg
    sudo cp -rf /Volumes/Docker/Docker.app $DOCKER_BIN
    hdiutil detach -quiet /Volumes/Docker 
    open -a Docker
    echo "docker installed"
else
    echo "docker already installed"
fi

echo "Tapping Brew Bundle..."
$BREW_BIN tap Homebrew/bundle

echo "Installing apps/binaries..."
$BREW_BIN bundle