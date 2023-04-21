#!/usr/bin/env bash

#source ./src/modules/repositories.sh

# RPM Fusion free and nonfree repositories
sudo dnf install --color=always -qy https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install --color=always -qy https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade --refresh --color=always -qy
sudo dnf groupupdate core --color=always -qy
sudo dnf install --color=always -qy rpmfusion-free-release-tainted
sudo dnf install --color=always -qy dnf-plugins-core

# Flatpak is installed by default
# but one needs to enable the Flathub store
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Snap support
sudo dnf install --color=always -y snapd
sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
sudo snap install core
sudo snap refresh core
sudo snap refresh

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

#echo "Download dotfiles"
#git clone --bare https://github.com/w23b07d28/dotfiles.git "$HOME/.dotfiles"
