#!/bin/bash

echo "Install programs.."

IFS=" " read -r -a programs <<< "$(find ./src/programs -type f | sed 's!.*/!!' | tr '\n' ' ')"
sudo xbps-install -y "${programs[@]}"


echo "Download dotfiles"
git clone --bare https://github.com/balintkiraly/.dotfiles.git $HOME/.dotfiles
