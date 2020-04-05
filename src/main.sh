#!/bin/sh

main() {
    sudo xbps-install $(find ./src/programs -type f | sed 's!.*/!!' | tr '\n' ' ')
}

echo "Install programs.."
main
