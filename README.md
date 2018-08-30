# AK MacOS Setup

This repo contains a script that will install useful applications and utilities on MacOS.

### What will be installed?
- AWS CLI
- BOSH CLI
- Cloud Foundry CLI
- Docker
- Git
- Go
- Homebrew
- RBEnv
- Terraform
- Visual Studio Code

### How do I run it?

There's a chicken and egg situation here. Git isn't configured on MacOS out of the box and this script will install git for you.

Download the zip file: https://github.com/armakuni/macos-setup/archive/master.zip

``` sh
unzip -d ~/Downloads/ ~/Downloads/macos-setup-master.zip
bash ~/Downloads/macos-setup-master/setup.sh
```
