# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Start X if not running
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
    exec startx
fi
