slock

urxvtd &
xrdb -merge ~/.Xresources
nitrogen --restore

horiz_res=$(xrandr | head -n3 | tail -n1 | sed 's/\s\+\([0-9]\+\).*/\1/g')
[[ $horiz_res > 2000 ]] && xrandr --output eDP1 --scale 0.5x0.5

awesome
