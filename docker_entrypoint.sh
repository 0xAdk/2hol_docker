#!/usr/bin/env sh

# create directory at each symlink's target if it doesn't already exist
mkdir -p $(readlink -f curseLog failureLog foodLog lifeLog mapChangeLogs)

# make stdout and stderr line buffered
exec stdbuf -oL -eL "$@"
