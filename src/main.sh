#!/bin/bash
source ./src/modules/yaml.sh

echo "Install programs.."

find ./src/programs -type f -print0 | while IFS= read -r -d $'\0' file; 
do
  package_name=$(basename $file)
  base_name=$(echo $package_name | tr "-" "_") 
  create_variables $file $base_name

  preinstall="${base_name}preinstall"
  install="${base_name}install"
  postinstall="${base_name}postinstall"

  [ -n "${!preinstall}" ] && eval $(echo ${!preinstall})

  if [ -n "${!install}" ]; then
    eval $(echo ${!install})
  else
    sudo xbps-install ${package_name} -y
  fi

  [ -n "${!postinstall}" ] && eval $(echo ${!postinstall})

done


echo "Download dotfiles"
git clone --bare https://github.com/balintkiraly/.dotfiles.git "$HOME/.dotfiles"
