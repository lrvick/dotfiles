export PYENV_ROOT="$HOME/.pyenv"
export GOPATH=~/.local/lib/go/
export NPM_PACKAGES="$HOME/.npm-packages"
export TASKDDATA=$HOME/.config/taskd

path=("$PYENV_ROOT/bin" $path)
path=("$HOME/.local/bin" $path)
path=("$(ruby -e 'puts Gem.user_dir')/bin" $path)
path=("$HOME/.rvm/bin" $path)
path=("$HOME/.pyenv/shims:$HOME/.pyenv/bin" $path) # Add pyenv
path=("$HOME/.local/lib/go/bin" $path)
path=("$HOME/.luarocks/bin" $path)
path=("$HOME/Sources/gcs/bin" $path)
path=("$HOME/.host_config/$HOST/bin" $path)
path=("$NPM_PACKAGES/bin" $path)
path=($^path(N)) # remove paths that don't exist

# Devtool Env
[[ -s "$HOME/.travis/travis.sh" ]] && \
    source "$HOME/.travis/travis.sh"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && \
    source "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.pyenv/bin/pyenv" ]] && \
    eval "$(pyenv init -)"

# Always use gpg2
[[ -f /usr/bin/gpg2 ]] && alias gpg="/usr/bin/gpg2"

#man theme
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
