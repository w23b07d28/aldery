#!/bin/bash

#!/bin/sh
echo "Install git and clone the Aldery repository to start installation..."

rm -rf /tmp/aldery

sudo dnf install git -y
git clone https://github.com/w23b07d28/aldery.git /tmp/aldery
cd /tmp/aldery || exit

bash ./src/main.sh