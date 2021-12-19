#!/usr/bin/env sh

# Make sure the 2hol directory exists / we are in the root of the project
[ -d 2hol ] || echo -e "Error:\n    Failed to find the 2hol directory.\n    Make sure you are running the script from the root of the project"

git clone --depth 1 'https://github.com/twohoursonelife/OneLife.git'  ./2hol/OneLife
git clone --depth 1 'https://github.com/twohoursonelife/OneLifeData7' ./2hol/OneLifeData7
git clone --depth 1 'https://github.com/twohoursonelife/minorGems'    ./2hol/minorGems
