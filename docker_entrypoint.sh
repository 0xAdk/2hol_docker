#!/usr/bin/env sh

# make sure main server_data directories exist
mkdir -p /server_data/data /server_data/cache /server_data/log

# create directory at each symlink's target if it doesn't already exist
mkdir -p $(readlink -f curseLog failureLog foodLog lifeLog mapChangeLogs)

# make stdout and stderr line buffered
exec stdbuf -oL -eL "$@"
