#!/usr/bin/env bash

# Local ad blocker

curl -o maza https://raw.githubusercontent.com/tanrax/maza-ad-blocking/master/maza
chmod +x maza
sudo mv maza /usr/local/bin
maza update
sudo maza stop
sudo maza start
