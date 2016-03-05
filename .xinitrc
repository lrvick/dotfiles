slock

xrdb -merge ~/.Xresources

if [[ "$MODEL" == "samus" ]]; then
    xbindkeys ~/.xbindkeys/samus
fi

source setdpi

nitrogen --restore

chromium &
urxvtd &
urxvtc &

awesome
