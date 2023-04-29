#!/usr/bin/env bash

# Welcoming the passenger on board
echo -e "\033[1m\033[32mHi. You just ran a script that will optimize Fedora Linux for you.\033[0m"
echo -e "\033[1m\033[32mSit back and pray that you don't see too many errors in your terminal.\033[0m"
echo -e "\033[1m\033[32mHave a pleasant trip.\033[0m"
echo -e "\033[1m\033[32mThank you.\033[0m"
echo -e "\033[1m\033[32m---\033[0m"
echo -e "\033[1m\033[32mTo begin with, I will delete any previous Aldery installation, if one exists in the temporary folder.\033[0m"

# Remove any previous Aldery installation
rm -rf /tmp/aldery

echo -e "\033[1m\033[32mIf one existed, it was deleted. Moving on.\033[0m"

# Install Git
echo -e "\033[1m\033[32mNow I will install git related packages so that I can run the script. They're probably already installed on your Fedora, but I'm coming from the Void Linux world and I preferred to keep it here just in case.\033[0m"

sudo dnf install --color=always -qy git git-lfs gh

echo -e "\033[1m\033[32mOkay, done.\033[0m"

# Clone the Aldery repository to /tmp/aldery and run the installation script
echo -e "\033[1m\033[32mNow I will clone the Aldery repository from Github to your computer and start the installation. We will see each other again in the second script. See you there!\033[0m"

git clone https://github.com/w23b07d28/aldery.git /tmp/aldery
cd /tmp/aldery || exit

bash ./src/main.sh