#!/usr/bin/env sh

# make stdout and stderr line buffered
stdbuf -oL -eL "$@"
