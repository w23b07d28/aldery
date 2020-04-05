#!/bin/sh

main() {
    sudo xbps-install -y $(find ./src/programs -type f | sed 's!.*/!!' | tr '\n' ' ')
}

echo "Install programs.."
main
