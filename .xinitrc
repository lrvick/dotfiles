slock

xrdb -merge ~/.Xresources

source ~/.device
if [[ "$MODEL" == "samus" ]]; then
    xbindkeys ~/.xbindkeys/samus
fi

source setdpi

nitrogen --set-scaled ~/.wallpaper/tags.jpg 

chromium &
urxvtd &
urxvtc &

awesome
