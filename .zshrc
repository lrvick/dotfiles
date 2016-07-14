#oh-my-zsh
ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="lrvick"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git vi-mode docker pass systemd z)
source $ZSH/oh-my-zsh.sh

# Always use gpg2
[ -f /usr/bin/gpg2 ] && alias gpg="/usr/bin/gpg2"

#powerline
pl_python_path=$(pip show powerline-status | grep Location | sed 's/Location: //g')
pl_zsh_module=${pl_python_path}/powerline/bindings/zsh/powerline.zsh
[ -f "$pl_zsh_module" ] && source "$pl_zsh_module"

#travis
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

#rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#pyenv
[[ -s "$HOME/.pyenv/bin/pyenv" ]] && eval "$(pyenv init -)"

# GPG Agent Setup - If connected locally
if [ -z "$SSH_TTY" ]; then

    # setup local gpg-agent with ssh support and save env to fixed location
    # so it can be easily picked up and re-used for multiple terminals
    envfile="$HOME/.gnupg/gpg-agent.env"
    if [[ ! -e "$envfile" ]] || ( \
           # deal with changed socket path in gnupg 2.1.13
           [[ ! -e "$HOME/.gnupg/S.gpg-agent" ]] && \
           [[ ! -e "/var/run/user/$(id -u)/gnupg/S.gpg-agent" ]]
       );
    then
        killall gpg-agent
        gpg-agent --daemon --enable-ssh-support > $envfile
    fi

    # Get latest gpg-agent socket location and expose for use by SSH
    eval "$(cat "$envfile")" && export SSH_AUTH_SOCK

    # Wake up smartcard to avoid races
    gpg --card-status > /dev/null 2>&1 
fi

# If running remote via SSH
if [ ! -z "$SSH_TTY" ]; then

    # Copy gpg-socket forwarded from ssh to default location
    # This allows local gpg to be used on the remote system transparently.
    # Strongly discouraged unless GPG managed with a touch-activated GPG 
    # smartcard such as a Yubikey 4.
    # Also assumes local .ssh/config contains host block similar to:
    # Host someserver.com
    #     ForwardAgent yes
    #     StreamLocalBindUnlink yes
    #     RemoteForward /home/user/.gnupg/S.gpg-agent.ssh /home/user/.gnupg/S.gpg-agent
    if [ -e $HOME/.gnupg/S.gpg-agent.ssh ]; then
        mv $HOME/.gnupg/S.gpg-agent{.ssh,}
    elif [ -e "/var/run/user/$(id -u)/gnupg/S.gpg-agent" ]; then
        mv /var/run/user/$(id -u)/gnupg/S.gpg-agent{.ssh,}
    fi
    
    # Ensure existing sessions like screen/tmux get latest ssh auth socket
    # Use fixed location updated on connect so in-memory location always works
    if [ ! -z "$SSH_AUTH_SOCK" -a \
        "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ];
    then
        unlink "$HOME/.ssh/agent_sock" 2>/dev/null
        ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    fi
    export SSH_AUTH_SOCK = "$HOME/.ssh/agent_sock"
fi
