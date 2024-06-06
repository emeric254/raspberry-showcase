#!/bin/bash

# make sure we are working from this script directory
cd "$(dirname "$0")" || exit 1

# call raspi-config to setup auto-login to desktop
sudo raspi-config nonint do_boot_behaviour B4

# install needed dependencies
sudo apt-get update -q
sudo apt-get install -qy unclutter x11-xserver-utils xdotool feh mpv chromium

# tweak video output
sudo sed -i "s/hdmi_force_hotplug=0/hdmi_force_hotplug=1/" /boot/config.txt
sudo sed -i "s/disable_overscan=0/disable_overscan=1/" /boot/config.txt

# disable ugly raspberry bootloader splash screen
grep -q "disable_splash" /boot/config.txt && sudo sed -i "s/disable_splash=0/disable_splash=1/" /boot/config.txt || sudo su -c "echo 'disable_splash=1' >> /boot/config.txt"

# removeing cursor on boot
grep "vt.global_cursor_default=0" /boot/firmware/cmdline.txt  || sudo su -c "sed -e 's/$/ vt.global_cursor_default=0/' /boot/firmware/cmdline.txt >> /boot/firmware/cmdline.txt "

# copy the desired splash logo
sudo cp ./splash.png /usr/share/plymouth/themes/pix/splash.png
echo "generating boot splash screen, this might take a while, please wait..."
sudo plymouth-set-default-theme --rebuild-initrd pix

####
# thanks to https://github.com/ugotapi/pagepi

# autohide taskbar by copying panel file to user profile and editing it disable updater notifications
sudo rm -rf /home/pi/.config/lxpanel
cp -a -f /etc/xdg/lxpanel ~/.config/lxpanel
awk 'NR==FNR{if (/  type=updater/) for (i=-1;i<=3;i++) del[NR+i]; next} !(FNR in del)' /etc/xdg/lxpanel/LXDE-pi/panels/panel /etc/xdg/lxpanel/LXDE-pi/panels/panel | dd of=~/.config/lxpanel/LXDE-pi/panels/panel

# edit file to hide panel
sed -i "s/autohide=.*/autohide=1/" ~/.config/lxpanel/LXDE-pi/panels/panel
sed -i "s/heightwhenhidden=.*/heightwhenhidden=0/" ~/.config/lxpanel/LXDE-pi/panels/panel
sed -i '/  point_at_menu=0/a notifications=0' ~/.config/lxpanel/LXDE-pi/panels/panel

# no window border
sudo rm -rf /home/pi/.config/openbox
mkdir -p ~/.config/openbox
cp /etc/xdg/openbox/rc.xml  ~/.config/openbox/rc.xml
sed -i "s/<keepBorder>yes/<keepBorder>no/" ~/.config/openbox/rc.xml

# no decorations
sed -i "s#</applications>#<application class=\"*\"> <decor>no</decor>  </application> </applications>#" ~/.config/openbox/rc.xml

# no blank screen
rm -rf ~/.config/lxsession/LXDE-pi
mkdir -p ~/.config/lxsession/LXDE-pi
cat <<EOF > ~/.config/lxsession/LXDE-pi/autostart
@xset s noblank
@xset -dpms
@xset s off
sh /home/pi/raspberry-showcase/start.sh

EOF

#change setting to openbox
cp /etc/xdg/lxsession/LXDE-pi/desktop.conf ~/.config/lxsession/LXDE-pi/desktop.conf
sed -i "s/window_manager=.*/window_manager=openbox/" ~/.config/lxsession/LXDE-pi/desktop.conf

####
# finally sync disk and reboot
sync
sudo reboot
