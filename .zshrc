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

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ls='ls -hF --color=always'

EDITOR="vim"

source /usr/bin/virtualenvwrapper.sh
export WORKON_HOME=~/Envs
export PS1="${VIRTUAL_ENV#*Envs/}%{$fg[green]%}%n@%m%{$fg[blue]%}% > "
