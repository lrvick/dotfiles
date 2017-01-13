export EDITOR=vim
export TZ='America/Los_Angeles'
export QT_DEVICE_PIXEL_RATIO=auto
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH=~/.local/lib/go/
export TASKDDATA=$HOME/.config/taskd

path=("$PYENV_ROOT/bin" $path)
path=('/opt/android-sdk/platform-tools' $path)
path=('/opt/android-sdk/tools' $path)
path=("$HOME/.local/bin" $path)
path=("$(ruby -e 'puts Gem.user_dir')/bin" $path)
path=("$HOME/.rvm/bin" $path)
path=("$HOME/.pyenv/shims:$HOME/.pyenv/bin" $path) # Add pyenv
path=("$HOME/.local/lib/go/bin" $path)
path=("$HOME/Sources/qemu/build/arm-softmmu" $path)
path=("$HOME/Sources/gcc-arm-none-eabi/bin" $path)
path=("$HOME/Sources/PebbleSDK/bin" $path)
path=("$HOME/Sources/gcs/bin" $path)
path=($^path(N)) # remove paths that don't exist

# device specific env kept out of git
[ -f ~/.device ] && source ~/.device 
