#!/usr/bin/env bash

# Install local ad blocker

curl -o maza https://raw.githubusercontent.com/tanrax/maza-ad-blocking/master/maza
chmod +x maza
sudo mv maza /usr/local/bin
maza update
sudo maza start