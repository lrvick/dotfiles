#!/bin/sh
xrandr --output HDMI1 --off --output DP1 --off --output eDP1 --mode 1200x1920 --pos 0x0 --rotate right --output VIRTUAL1 --off
xinput set-prop 15 --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
#!/bin/sh
