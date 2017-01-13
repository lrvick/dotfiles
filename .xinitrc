#!/bin/bash

# Lock screen right away
slock

# Setup HiDPI scaling vars as needed
source setdpi

# Load Global X settings (Terminal config, fonts, etc)
xrdb -merge ~/.Xresources

# Set Wallpaper
nitrogen --set-scaled ~/.wallpaper/tags.jpg

# Load system-specific keyboard/screen config
host_config="$HOME/.host_config/$HOST"
[[ -f "$host_config/xbindkeys" ]] && xbindkeys -f $host_config/xbindkeys
[[ -f "$host_config/screenlayout.sh" ]] && bash $host_config/screenlayout.sh

# Launch Browser
qutebrowser &

# Terminal Setup
termite & # Client

# Setup terminal defaults in window manager scope
source .zshrc &

# Start Window Manager
awesome
