#!/bin/bash

source /home/pi/raspberry-showcase/config.sh

# verify chromium is installed
which chromium-browser || exit 1

# reset chrome crash flag
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

# start chrome
chromium-browser --noerrdialogs --disable-infobars --disable-session-crashed-bubble --disable-features=TranslateUI --kiosk --app=$CHROME_URL
