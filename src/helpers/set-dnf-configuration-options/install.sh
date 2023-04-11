#!/usr/bin/env bash

# Several methods can enhance the speed of downloading packages in Fedora.
# By selecting the fastest mirrors, the package download speed can increase.
# Furthermore, if you have a sufficiently faster internet connection,
# then the number of parallel downloads can be changed to get faster downloads.
# The fastest mirrors work by selecting the mirror with the lowest latency.
# The speed difference may or may not be noticeable.

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
