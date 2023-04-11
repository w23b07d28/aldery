#!/usr/bin/env bash

source ./src/modules/yaml.sh
BASEDIR=$(pwd)

# Enable RPM Fusion Repository
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Add Flathub Repository
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y

# Enable snaps
sudo dnf install snapd -y
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install core
sudo snap refresh core

# Update the system
sudo dnf update -y
sudo dnf upgrade -y

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
    sudo dnf install -y "${package_name}"
  fi

  # shellcheck disable=SC2086
  [ -n "${!postinstall}" ] && eval ${!postinstall}

  cd "$BASEDIR" || exit
done

#echo "Download dotfiles"
#git clone --bare https://github.com/w23b07d28/dotfiles.git "$HOME/.dotfiles"
