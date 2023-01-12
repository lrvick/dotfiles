export BROWSER="${HOME}/.local/bin/qutebrowser"
export EDITOR="nvim"
export TZ="America/Los_Angeles"
export GTK_THEME="Adwaita:dark"
export GOPATH=~/.local/lib/go/
export NPM_PACKAGES="$HOME/.npm-packages"
export TASKDDATA=$HOME/.config/taskd

# Apply QubesOS specific configuration
if command -v qubesdb-read &> /dev/null; then
	export SSH_VAULT_VM="vault";
	export SSH_AUTH_SOCK="/home/${USER}/.SSH_AGENT_${SSH_VAULT_VM}";
	git config --global gpg.program qubes-gpg-client-wrapper;
	ln -sf /bin/qubes-gpg-client-wrapper ~/.local/bin/gpg
	ln -sf /bin/qubes-gpg-client-wrapper ~/.local/bin/gpg2
else
	# Always use gpg2
	[[ -f /usr/bin/gpg2 ]] && alias gpg="/usr/bin/gpg2"
fi

alias vi="nvim"
alias vim="nvim"

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
