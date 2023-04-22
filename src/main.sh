#!/usr/bin/env bash

# Update system
echo -e "\033[1m\033[32mWe've just moved on to the main script, so why not start by updating and upgrading your system.\033[0m"

sudo dnf update --color=always -qy
sudo dnf upgrade --color=always -qy
sudo dnf upgrade --color=always --refresh -qy
sudo dnf check --color=always -qy
sudo dnf autoremove --color=always -qy
sudo fwupdmgr get-devices -y
sudo fwupdmgr refresh --force -y
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

echo -e "\033[1m\033[32mOkay, done. Now let's load the modules we need. That is, we want to have access to various repositories and the tool that makes this script work the way it does.\033[0m"
source ./src/modules/repositories.sh
source ./src/modules/yaml.sh
BASEDIR=$(pwd)

# Install programs
echo -e "\033[1m\033[32mNow we will run all the other scripts.\033[0m"

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
echo -e "\033[1m\033[32mIt's almost there. I'll just clean up after myself yet.\033[0m"
[ -e ~/install.sh ] && rm ~/install.sh

#echo "Download dotfiles"
#git clone --bare https://github.com/w23b07d28/dotfiles.git "$HOME/.dotfiles"

echo -e "\033[1m\033[32mEverything has been done. Don't sit too much in front of the computer and lift with a straight back from bent knees. Bye!\033[0m"
