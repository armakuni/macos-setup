#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

BREW_BIN="/usr/local/bin/brew"
GIT_BIN="/usr/bin/git"
CF_BIN="/usr/local/bin/cf"
RBENV_BIN="/usr/local/bin/rbenv"
GO_BIN="/usr/local/bin/go"
AWS_BIN="/usr/local/bin/aws"
DOCKER_BIN="/Applications/Docker.app"
BOSH_BIN="/usr/local/bin/bosh"
TERRAFORM_BIN="/usr/local/bin/terraform"
VSCODE_BIN="/Applications/VSCode.app"

echo "Checking if Homebrew is installed..."
if [ ! -f $BREW_BIN ]; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebew installed"
else
    echo "homebrew already installed"
fi


echo "Checking if Git is installed..."
if [ ! -f $GIT_BIN ]; then
    echo "Installing Git"
    $BREW_BIN install git
    echo "Git installed"
else
    echo "git already installed"
fi

echo "Checking if cf-cli is installed..."
if [ ! -f $CF_BIN ]; then
    echo "Installing cf-cli"
    curl -s "https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.38.0/cf-cli_6.38.0_osx.tgz" -o /tmp/cf-cli.tgz
    mkdir -p /tmp/cf-cli/
    tar -xzf /tmp/cf-cli.tgz -C /tmp/cf-cli/
    sudo mv /tmp/cf-cli/cf $CF_BIN
    sudo rm -rf /tmp/cf-cli*
    sudo chmod a+x $CF_BIN
    echo "cf-cli installed"
else
    echo "cf-cli already installed"
fi

echo "Checking if rbenv is installed..."
if [ ! -f $CF_BIN ]; then
    echo "Installing rbenv"
    $BREW_BIN install rbenv
    echo "rbenv installed"
else
    echo "rbenv already installed"
fi

echo "Checking if go is installed..."
if [ ! -f $GO_BIN ]; then
    echo "Installing go"
    curl -s https://dl.google.com/go/go1.11.darwin-amd64.tar.gz -o /tmp/go1.11.tar.gz
    mkdir -p /tmp/go1.11/
    tar -xzf /tmp/go1.11.tar.gz -C /tmp/go1.11/
    cp -rf /tmp/go1.11/go/bin/go $GO_BIN
    rm -rf /tmp/go1.11*

    GOPATH="~/go-workspace"
    mkdir -p $GOPATH $GOPATH/src/ $GOPATH/bin/ $GOPATH/pkg/
    echo "GOPATH=${GOPATH}" >> ~/.bash_profile
    echo "go installed"
else
    echo "go already installed"
fi

echo "Checking if aws-cli is installed..."
if [ ! -f $AWS_BIN ]; then
    echo "Installing aws-cli"
    echo "(Checking if pip is installed)"
    if [ ! -f /usr/local/bin/pip ]; then
        echo "(Installing pip)"
        sudo easy_install -q pip
        echo "(Pip installed)"
    else
        echo "(Pip already installed)"
    fi

    pip install awscli --upgrade --user
    echo "aws-cli installed"
else
    echo "aws-cli already installed"
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

echo "Checking if bosh-cli is installed..."
if [ ! -f $BOSH_BIN ]; then
    echo "Installing bosh-cli"
    curl -L -s https://github.com/cloudfoundry/bosh-cli/releases/download/v5.2.2/bosh-cli-5.2.2-darwin-amd64 -o /tmp/bosh-cli
    sudo cp /tmp/bosh-cli $BOSH_BIN
    sudo rm -rf /tmp/bosh-cli
    sudo chmod a+x $BOSH_BIN
    echo "bosh-cli installed"
else
    echo "bosh-cli already installed"
fi

echo "Checking if terraform is installed..."
if [ ! -f $TERRAFORM_BIN ]; then
    echo "Installing terraform"
    curl -s https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_darwin_amd64.zip -o /tmp/terraform.zip
    unzip -d /tmp/terraform/ /tmp/terraform.zip
    sudo cp /tmp/terraform/terraform $TERRAFORM_BIN
    sudo chmod a+x $TERRAFORM_BIN
    rm -rf /tmp/terraform*
    echo "terraform installed"
else
    echo "terraform already installed"
fi

echo "Checking if vscode is installed..."
if [ ! -d $VSCODE_BIN ]; then
    echo "Installing vscode (this may take a few minutes)"
    if [ ! -f ~/Downloads/vscode.zip ]; then
        curl -s https://az764295.vo.msecnd.net/stable/493869ee8e8a846b0855873886fc79d480d342de/VSCode-darwin-stable.zip -o ~/Downloads/vscode.zip
    fi

    unzip -q -d /tmp/vscode/ ~/Downloads/vscode.zip
    sudo cp -rf /tmp/vscode/Visual*.app $VSCODE_BIN

    rm -rf /tmp/vscode/
    echo "vscode installed"
else
    echo "vscode already installed"
fi
