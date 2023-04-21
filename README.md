# Aldery

![Logo](assets/logo.png)

## About

Overall, Aldery is a simple tool for streamlining the post-installation, configuration, and optimization of Fedora Linux. Its automation capabilities and customization features make it an excellent starting point for creating customized Linux distributions with sets of scripts that can be easily adapted to other platforms.

What will come out of this? I have no idea. From the point of view of some, it's just a slightly more in depth version of the typical .dotfiles.

## Features

Specifically, the script automates the following tasks:

* Updating and upgrading the system
* Configuring DNF for faster package downloads
* Enabling key repositories, including RPM Fusion, Flathub, and Snaps
* Installing multimedia codecs for accessing various media formats
* Customizing system settings for optimal performance
* Installs a host-level ad blocker.
* Install *some* apps

## Usage

To use Aldery, simply run the installation script from the repository's root directory:

```bash
curl -LO https://raw.githubusercontent.com/w23b07d28/aldery/master/install.sh && sh install.sh
```

This will automatically download and execute the installation script, which will guide you through the process of setting up your Fedora Linux system.

## Disclaimer

The entire project is based on a mild fascination with a YAML parser written in Bash. The traversal logic is superb; it is quite enjoyable to experiment with unconventional techniques using Bash, and adhering to the POSIX shell standard is the optimal approach. Well, after all, you can use Ansible for that, right?

Please note that Aldery is still in development and may not be suitable for use in production environments. The author takes no responsibility for any damages that may occur as a result of using this script. Use at your own risk.
