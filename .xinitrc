slock

xrdb -merge ~/.Xresources

source setdpi

nitrogen --set-scaled ~/.wallpaper/tags.jpg 

# Load host-specific keyboard/screen configurations
host_config="$HOME/.host_config/$HOST"
[[ -f "$host_config/xbindkeys" ]] && xbindkeys -f $host_config/.xbindkeys
[[ -f "$host_config/screenlayout.sh" ]] && bash $host_config/screenlayout.sh

chromium &
urxvtd &
urxvtc &

awesome
