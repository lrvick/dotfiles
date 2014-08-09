# Start X if not running
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 && -x /usr/bin/startx ]] && (( EUID )); then
    exec startx
else
    eval $(keychain --eval id_rsa 36C8AAA9)
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#autossh -M 0 -gfNCR :2242:localhost:22 -o TCPKeepAlive=yes og.hashbang.sh
