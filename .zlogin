# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Start X if not running
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 && command -v startx &>/dev/null ]] && (( EUID )); then
    exec startx
else
    eval $(keychain --eval id_rsa 36C8AAA9)

    #Set up Python Virtualenvwrapper
    export WORKON_HOME=~/.virtualenvs
    export VIRTUALENVWRAPPER_LOG_DIR=~/.virtualenvs
    export VIRTUALENVWRAPPER_HOOK_DIR=~/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi
