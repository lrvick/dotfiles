HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep nomatch notify

autoload -Uz compinit
compinit
autoload -U promptinit colors
promptinit
colors
prompt walters

bindkey -e # This will enable emacs keybindings I'm "used" to.
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

EDITOR="vim"

export PS1="%{$fg[green]%}%n@%m%{$fg[blue]%}% > "
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_LOG_DIR=~/.virtualenvs
export VIRTUALENVWRAPPER_HOOK_DIR=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Magical aliases
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ls='ls -hF --color=always'
alias logs="sh ~/Scripts/logs.sh"
alias uwlogs="sh ~/Scripts/uwlogs.sh"
alias tklogs="sh ~/Scripts/tawlklogs.sh"

eval $(keychain --eval id_rsa 36C8AAA9)
