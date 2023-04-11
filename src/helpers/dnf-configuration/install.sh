#!/usr/bin/env bash

# By selecting the fastest mirrors, the package download speed can increase.
# The fastest mirrors work by selecting the mirror with the lowest latency.

fastestmirror=true
deltarpm=true

# Set DNF configuration options
CONF_FILE="/etc/dnf/dnf.conf"
CONF_OPTS=("max_parallel_downloads=10" "fastestmirror=true" "deltarpm=true")

for OPT in "${CONF_OPTS[@]}"; do
    if ! grep -q "^${OPT}$" "$CONF_FILE"; then
        echo "$OPT" >> "$CONF_FILE"
    fi
done
