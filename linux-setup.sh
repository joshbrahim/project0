#!/bin/bash

# step 1 : setting up
echo 'Need to install/update programs...'
cd ~

#updates
apt update
apt -y upgrade
sudo apt-get install -y build-essential curl file git

#install brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'brew installed/updated'

#install az
brew install azure-cli
echo 'az installed/updated'

#install git
brew install git
echo 'git installed/updated'

#install gcc
brew install gcc
echo 'gcc installed/updated'

#install node
brew install node
echo 'node installed/updated'

exit 0

