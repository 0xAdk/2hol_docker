#!/usr/bin/env sh

redirect_to_config() {
	FILE="$1"

	# the file is already a symlink, we don't have to move anything
	if [ -L "$FILE" ]; then
		return
	fi

	# place the file in server config if it doesn't already exist
	if [ ! -e "/server_data/config/${FILE}" ] && [ -e "${FILE}" ]; then
		mv "${FILE}" "/server_data/config/${FILE}"
	fi

	# replace the file with a symlink to the file in the servers config directory
	rm -r "${FILE}"
	ln -s "/server_data/config/${FILE}"
}


# make sure main server_data directories exist
mkdir -p /server_data/data /server_data/cache /server_data/log /server_data/config

# create directory at each symlink's target if it doesn't already exist
mkdir -p $(readlink -f curseLog failureLog foodLog lifeLog mapChangeLogs)

# make sure settings are exposed through the config directory
redirect_to_config settings

# make stdout and stderr line buffered
exec stdbuf -oL -eL "$@"
