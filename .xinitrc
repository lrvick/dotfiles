#!/bin/bash

# Setup HiDPI scaling vars as needed
source setdpi

# Load Global X settings (Terminal config, fonts, etc)
xrdb -merge ~/.Xresources

# Load system-specific keyboard/screen config
host_config="$HOME/.host_config/$(cat /etc/hostname)"
[[ -f "$host_config/xbindkeys" ]] && xbindkeys -f "$host_config/xbindkeys"
[[ -f "$host_config/screenlayout.sh" ]] && source "$host_config/screenlayout.sh"

# Initialize GPG Agent
gpg-init &

# Start compositer
compton &

# Set Wallpaper
nitrogen --set-scaled ~/.wallpaper/tags.jpg

# Launch Browser
qutebrowser &

# Terminal Setup
urxvtd &
urxvtc & # Client

# Start Window Manager
awesome
