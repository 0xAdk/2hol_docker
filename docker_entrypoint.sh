#!/usr/bin/env sh

# make sure main server_data directories exist
mkdir -p /server_data/data /server_data/cache /server_data/log /server_data/config

# create directory at each symlink's target if it doesn't already exist
mkdir -p $(readlink -f curseLog failureLog foodLog lifeLog mapChangeLogs)

# make sure settings is symlinked into the server_data/config directory
## if settings is already a symlink skip this
if [ ! -L settings ]; then
	# if we don't already have settings directory in our server data directory
	# take the (presumably default) settings from the docker file
	if [ ! -d /server_data/config/settings ]; then
		mv settings /server_data/config/settings
	fi

	# replace the default settings directory with a symlink to server's setting directory
	rm -r settings
	ln -s /server_data/config/settings
fi

# make stdout and stderr line buffered
exec stdbuf -oL -eL "$@"
