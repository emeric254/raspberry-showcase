# Raspberry showcase

Works on Raspberry pi 3 / 3+  "Bookworm"  (tested on 64 bit).

## Purpose

Use a Raspberry connected to a monitor as a communication tool to display various kind of content.

Its features are :
  - picture continuous slideshow  (this is the default task, displaying everything in the `~/Pictures` folder)
  - video playback (this loop forever, by default loading them from the `~/Videos` folder)
  - web browser kiosk (this load by default `https://google.com`)

## Recommendations

Using the target screen resolution for your various assets (images, videos) is highly recommended.

## Installation

Everything in the setup assume that the default user is `pi`.
It also assume that this repository name is used as folder name and is placed into your home folder.
You may need many modification in the various files if you want to change that behavior.

First make sure your Raspberry is running the official Raspbian desktop.
You can copy and edit the `custom.toml` file to setup automatically your fresh install.
If your Raspberry pi is already installed go directly to the next step.

Now you can boot the Raspberry pi.

Once you are connected onto it (ssh or locally), you can clone this repository in your home folder.

```sh
cd ~/
git clone https://github.com/emeric254/raspberry-showcase.git
cd ~/raspberry-showcase/
```

You can replace the `splash.png` file by your own image or logo.

```sh
scp path/to/your/splash.png pi@raspberrypi-ip:~/raspberry-showcase/
```

Then modify `config.sh`  to your convenience.

```sh
nano ~/raspberry-showcase/config.sh
```

Finally run the `install.sh` script.

```sh
bash install.sh
```

