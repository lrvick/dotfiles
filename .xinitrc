slock

xrdb -merge ~/.Xresources

if [[ "$MODEL" == "samus" ]]; then
    xbindkeys -f ~/.xbindkeys/samus
fi

source setdpi

nitrogen --set-scaled ~/.wallpaper/tags.jpg 

chromium &
urxvtd &
urxvtc &

awesome
