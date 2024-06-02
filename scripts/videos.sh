#!/bin/bash

source ~/raspberry-showcase/config.sh

# verify omxplayer is installed
which mpv || exit 1

FILES=$VIDEO_FOLDER/*
for f in $FILES
do
  mpv --realy-quiet "$f" > /dev/null 2>&1
done
