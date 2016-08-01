export EDITOR=vim
export TZ='America/Los_Angeles'

path=('/opt/android-sdk/platform-tools' $path)
path=('/opt/android-sdk/tools' $path)
path=("$HOME/.local/bin" $path)
path=("$(ruby -e 'puts Gem.user_dir')/bin" $path)
path=("$HOME/.rvm/bin" $path)
path=("$HOME/.local/lib/go/bin" $path)
path=("$HOME/Sources/qemu/build/arm-softmmu" $path)
path=("$HOME/Sources/gcc-arm-none-eabi/bin" $path)
path=("$HOME/Sources/PebbleSDK/bin" $path)
path=($^path(N)) # remove paths that don't exist

export GOPATH=~/.local/lib/go/
export QT_DEVICE_PIXEL_RATIO=auto
export TASKDDATA=$HOME/.config/taskd

# device specific env kept out of git
[ -f ~/.device ] && source ~/.device 
