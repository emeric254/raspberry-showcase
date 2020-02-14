#!/bin/bash

function clear_screen {
  # move to tty1
  sudo su -c 'chvt 1'
  # clear the display
  sudo su -c "clear > /dev/tty1"
  # turn off the flashing cursor
  sudo su -c "setterm -cursor off > /dev/tty1"
}

function restore_screen {
  # restore flashing cursor
  sudo su -c "setterm -cursor on > /dev/tty1"
}
