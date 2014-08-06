# Add ~/bin to PATH
export PATH="$HOME/bin:`ruby -e 'puts Gem.user_dir'`/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Start X if not running
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 && -x /usr/bin/startx ]] && (( EUID )); then
    exec startx
else
    eval $(keychain --eval id_rsa 36C8AAA9)

    #Set up Python Virtualenvwrapper
    #export WORKON_HOME=~/.virtualenvs
    #export VIRTUALENVWRAPPER_LOG_DIR=~/.virtualenvs
    #export VIRTUALENVWRAPPER_HOOK_DIR=~/.virtualenvs
    #source /usr/bin/virtualenvwrapper.sh
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#autossh -M 0 -gfNCR :2242:localhost:22 -o TCPKeepAlive=yes og.hashbang.sh
