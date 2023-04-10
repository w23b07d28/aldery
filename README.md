# Aldery

## Introduction

Aldery is a script designed to simplify the installation, configuration, and optimization of Fedora Linux. The script is intended to be used as a starting point for creating a new and improved Linux distribution, which may eventually be ported to other platforms such as Void.

## Features

The Aldery script automates the following tasks:

* Installing and configuring essential packages
* Customizing system settings for optimal performance
* Removing unnecessary packages and files
* Configuring the desktop environment
* Applying security enhancements

## Usage

To use Aldery, simply run the installation script from the repository's root directory:

```bash
curl -LO https://raw.githubusercontent.com/w23b07d28/aldery/master/install.sh && sh install.sh
```

This will automatically download and execute the installation script, which will guide you through the process of setting up your Fedora Linux system.

## Disclaimer

The entire project is based on a mild fascination with a YAML parser written in Bash. The traversal logic is superb; it is quite enjoyable to experiment with unconventional techniques using Bash, and adhering to the POSIX shell standard is the optimal approach. Well, after all, you can use Ansible for that, right?

Please note that Aldery is still in development and may not be suitable for use in production environments. The author takes no responsibility for any damages that may occur as a result of using this script. Use at your own risk.
