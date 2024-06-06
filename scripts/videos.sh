#!/bin/bash

source /home/pi/raspberry-showcase/config.sh

# verify mpv is installed
which mpv || exit 1

FILES=$VIDEO_FOLDER/*
for f in $FILES
do
  mpv --realy-quiet "$f" > /dev/null 2>&1
done
