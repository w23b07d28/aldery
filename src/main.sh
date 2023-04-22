#!/usr/bin/env bash

# Update system
sudo dnf update --color=always -qy
sudo dnf upgrade --color=always -qy
sudo dnf upgrade --color=always --refresh -qy
sudo dnf check --color=always -qy
sudo dnf autoremove --color=always -qy
sudo fwupdmgr get-devices -y
sudo fwupdmgr refresh --force -y
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

source ./src/modules/repositories.sh
source ./src/modules/yaml.sh
BASEDIR=$(pwd)

# Install programs
find ./src/programs -type f -print0 | while IFS= read -r -d $'\0' file; 
do
  package_name=$(basename "$file")
  base_name=$(echo "$package_name" | tr "-" "_") 
  create_variables "$file" "$base_name"

  preinstall="${base_name}preinstall"
  install="${base_name}install"
  postinstall="${base_name}postinstall"

  # shellcheck disable=SC2086
  [ -n "${!preinstall}" ] && eval ${!preinstall}

  if [ -n "${!install}" ]; then
    # shellcheck disable=SC2086
    eval ${!install}
  else
    sudo dnf install --color=always -qy "${package_name}"
  fi

  # shellcheck disable=SC2086
  [ -n "${!postinstall}" ] && eval ${!postinstall}

  cd "$BASEDIR" || exit
done

# So that the script does not leave behind unnecessary garbage.
[ -e ~/install.sh ] && rm ~/install.sh

#echo "Download dotfiles"
#git clone --bare https://github.com/w23b07d28/dotfiles.git "$HOME/.dotfiles"

echo -e "\033[1m\033[32mEverything has been done. Don't sit too much in front of the computer and lift with a straight back from bent knees. Bye!\033[0m"
