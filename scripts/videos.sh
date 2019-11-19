#!/bin/bash

source ~/raspberry-showcase/config.sh

# verify omxplayer is installed
which omxplayer || exit 1

FILES=$VIDEO_FOLDER/*
for f in $FILES
do
  omxplayer -b -p -o hdmi --aspect-mode letterbox "$f" > /dev/null 2>&1
done
