#oh-my-zsh
ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="lrvick"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git git-extras mosh vi-mode docker pass systemd z taskwarrior docker docker-compose)
source $ZSH/oh-my-zsh.sh

#powerline
pl_zsh_module=/usr/share/powerline/bindings/zsh/powerline.zsh
[ -f "$pl_zsh_module" ] && source "$pl_zsh_module"

# OPAM configuration
. /home/lrvick/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
