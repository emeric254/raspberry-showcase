#!/bin/bash

cd "$(dirname "$0")"

source ~/raspberry-showcase/config.sh
source ~/raspberry-showcase/scripts/common.sh

while true
do
  clear_screen
  bash ~/raspberry-showcase/scripts/$TARGET.sh
  sleep $SLEEP
done
