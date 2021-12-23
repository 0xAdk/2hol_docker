#!/usr/bin/env sh

# make stdout and stderr line buffered
exec stdbuf -oL -eL "$@"
