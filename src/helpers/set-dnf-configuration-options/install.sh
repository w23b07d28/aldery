#!/usr/bin/env bash

# Set DNF configuration options
CONF_FILE="/etc/dnf/dnf.conf"
CONF_OPTS=("max_parallel_downloads=10" "fastestmirror=true" "deltarpm=true")

for OPT in "${CONF_OPTS[@]}"; do
    if ! grep -q "^${OPT}$" "$CONF_FILE"; then
        echo "$OPT" >> "$CONF_FILE"
    fi
done
