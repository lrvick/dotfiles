# Start X if not in SSH and X not running
if [[ -z "$SSH_TTY" && \
      -z $DISPLAY && \
      ! -e /tmp/.X11-unix/X0 && \
      -x /usr/bin/startx ]] && \
      (( EUID )); then
    exec startx
fi
