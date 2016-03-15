ZSH=$HOME/.oh-my-zsh

DEFAULT_USER="lrvick"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git vi-mode docker pass systemd z)

export PATH="/usr/local/bin:/usr/bin:/bin:/opt/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/opt/android-sdk/platform-tools:$PATH"
export PATH="/opt/android-sdk/tools:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:`ruby -e 'puts Gem.user_dir'`/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/Sources/qemu/build/arm-softmmu:$PATH"
export PATH="$HOME/Sources/gcc-arm-none-eabi/bin:$PATH"
export PATH="$HOME/Sources/PebbleSDK/bin:$PATH"
export PATH="$HOME/.local/lib/go/bin:$PATH"

export GOPATH=~/.local/lib/go/
export QT_DEVICE_PIXEL_RATIO=auto

source $ZSH/oh-my-zsh.sh
source `pip2 show powerline-status | grep Location | sed 's/Location: //g'`/powerline/bindings/zsh/powerline.zsh

[ -f /home/lrvick/.travis/travis.sh ] && source /home/lrvick/.travis/travis.sh

[ -f ~/.device ] && source ~/.device # device specific settings kept out of version control

if [ -z "$TMUX" ]; then
    if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
        unlink "$HOME/.ssh/agent_sock" 2>/dev/null
        ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
        export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
    fi
fi
