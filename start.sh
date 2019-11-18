#!/bin/bash

cd "$(dirname "$0")"

source ~/raspberry-showcase/config.sh

while true
do
  bash ~/raspberry-showcase/scripts/$TARGET.sh
  sleep $SLEEP
done
