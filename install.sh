# install needed dependencies
apt-get install -qy unclutter x11-xserver-utils

# configure desktop in kiosk mode

mkdir -p /home/pi/.config/lxsession/LXDE-pi/

cat <<EOF > /home/pi/.config/lxsession/LXDE-pi/autostart

# clear the tty screen
@xset s noblank
@xset s off
@xset -dpms

# hide mouse cursor when not moving
@unclutter -idle 0.3 -root &

# launch the start script
@bash /home/pi/raspberry-showcase/start.sh &

EOF

chown pi:pi -R /home/pi/.config/lxsession/LXDE-pi

# disable raspberry pi splash and make system boot quiet
PART=`mount | grep " / " | cut -f 1 -d " "`; echo "dwc_otg.lpm_enable=0 console=tty7 root=$PART rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0" > /boot/cmdline.txt

# tweak video output

sed -i "s/hdmi_force_hotplug=0/hdmi_force_hotplug=1/" /boot/config.txt

sed -i "s/disable_overscan=0/disable_overscan=1/" /boot/config.txt

# disable ugly raspberry bootloader splash screen

grep -q "disable_splash" /boot/config.txt && sed -i "s/disable_splash=0/disable_splash=1/" /boot/config.txt || echo "disable_splash=1" >> /boot/config.txt

# enable boot splash logo

chmod 644 /etc/plymouth/plymouthd.conf

cat <<EOF > /etc/plymouth/plymouthd.conf
[Daemon]
Theme=pix
ShowDelay=0

EOF

chmod 644 /etc/plymouth/plymouthd.conf

chmod 777 /usr/share/plymouth/themes/pix/splash.png

# copy the desired splash logo

cp ./logo.png /usr/share/plymouth/themes/pix/splash.png

chmod 644 /usr/share/plymouth/themes/pix/splash.png

# finally sync disk and reboot

sync

reboot
