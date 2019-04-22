#!/bin/bash

# step 1 : setting up
echo 'Need to install/update programs...'
cd ~

#sudo updates
sudo apt update
sudo apt -y upgrade

#install brew
sudo apt-get install -y build-essential curl file git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'brew installed/updated'

#install az
brew install azure-cli
echo 'az installed/updated'

#install git
brew install git
echo 'git installed/updated'

#install node
brew install node
echo 'node installed/updated'

exit 0

