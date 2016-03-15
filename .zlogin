# if connected locally (not over ssh)
if [ ! -z "$SSH_TTY" ]; then

    # Start X if not running
    if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 && -x /usr/bin/startx ]] && (( EUID )); then
        exec startx
    else
        # GPG Agent Setup
        envfile="$HOME/.gnupg/gpg-agent.env"
        if [[ ! -e "$envfile" ]] || [[ ! -e "$HOME/.gnupg/S.gpg-agent" ]]; then
            gpg-agent --daemon --enable-ssh-support > $envfile
        fi
        eval "$(cat "$envfile")"
        export SSH_AUTH_SOCK   # enable gpg-agent for ssh
    fi
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#autossh -M 0 -gfNCR :2242:localhost:22 -o TCPKeepAlive=yes og.hashbang.sh
