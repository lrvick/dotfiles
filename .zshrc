#oh-my-zsh
ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="lrvick"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git vi-mode docker pass systemd z)
source $ZSH/oh-my-zsh.sh

#powerline
pl_python_path=$(pip show powerline-status | grep Location | sed 's/Location: //g')
pl_zsh_module=${pl_python_path}/powerline/bindings/zsh/powerline.zsh
[ -f "$pl_zsh_module" ] && source "$pl_zsh_module"

#travis
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

#rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# GPG Agent Setup - If connected locally
if [ -z "$SSH_TTY" ]; then

    gpg --card-status > /dev/null 2>&1
    envfile="$HOME/.gnupg/gpg-agent.env"
    if [[ ! -e "$envfile" ]] || [[ ! -e "$HOME/.gnupg/S.gpg-agent" ]]; then
        gpg-agent --daemon --enable-ssh-support > $envfile
    fi
    eval "$(cat "$envfile")"
    export SSH_AUTH_SOCK   # enable gpg-agent for ssh
fi

# Ensure tmux always gets latest SSH_AUTH_SOCK
if [ -z "$TMUX" ]; then
    if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
        unlink "$HOME/.ssh/agent_sock" 2>/dev/null
        ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
        export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
    fi
fi
