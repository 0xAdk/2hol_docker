# About

A simple Dockerfile for building and setting up a 2hol server.

# Prerequisites

The Dockerfile expects the 3 repos required to build 2hol are found within the
`2hol/` directory.

These are
* [twohoursonelife/OneLife](https://github.com/twohoursonelife/OneLife)
* [twohoursonelife/OneLifeData7](https://github.com/twohoursonelife/OneLifeData7)
* [twohoursonelife/minorGems](https://github.com/twohoursonelife/minorGems)

This can be accomplished by either
1. cloning them in yourself
2. running the `./clone_in_2hol_repos.sh` helper script

# Running

## with docker cli

First build the image.
```
$ docker build . -t 2hol_server
```

Then start the container. The default port the 2hol server uses is 8005.
```
$ docker run -d \
	--name 2hol_server \
	-p 8005:8005 \
	2hol_server
```

## with docker-compose

The included docker-compose file will automatically build and start the image.
As well as open the server on port 8005.
```
$ docker-compose up -d
```
