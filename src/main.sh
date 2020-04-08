#!/bin/bash
source ./src/modules/yaml.sh

echo "Install programs.."

find ./src/programs -type f -print0 | while IFS= read -r -d $'\0' file; 
do
  package_name=$(basename "$file")
  base_name=$(echo "$package_name" | tr "-" "_") 
  create_variables "$file" "$base_name"

  preinstall="${base_name}preinstall"
  install="${base_name}install"
  postinstall="${base_name}postinstall"

  # shellcheck disable=SC2086
  [ -n "${!preinstall}" ] && ${!preinstall}

  if [ -n "${!install}" ]; then
    # shellcheck disable=SC2086
    ${!install}
  else
    sudo xbps-install -y "${package_name}"
  fi

  # shellcheck disable=SC2086
  [ -n "${!postinstall}" ] && ${!postinstall}

done


echo "Download dotfiles"
git clone --bare https://github.com/balintkiraly/.dotfiles.git "$HOME/.dotfiles"
