#!/bin/bash

cd "$(dirname "$0")" || exit 1

source ~/raspberry-showcase/config.sh

while true
do
  bash ~/raspberry-showcase/scripts/$TARGET.sh
  sleep $SLEEP
done
