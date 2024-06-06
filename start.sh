#!/bin/bash

cd "$(dirname "$0")" || exit 1

source ./config.sh || exit 1

while true
do
  bash "./scripts/$TARGET.sh"
  sleep "$SLEEP" || sleep 30  # to avoid getting the loop out of control
done
