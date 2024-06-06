#!/bin/bash

source ~/raspberry-showcase/config.sh

# verify feh is installed
which feh || exit 1

feh --quiet --preload --hide-pointer --fullscreen --slideshow-delay $SLIDESHOW_DELAY --recursive $IMAGE_FOLDER > /dev/null 2>&1
