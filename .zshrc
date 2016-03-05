## Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
#
## Set name of the theme to load.
## Look in ~/.oh-my-zsh/themes/
## Optionally, if you set this to "random", it'll load a random theme each
## time that oh-my-zsh is loaded.
##ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
DEFAULT_USER="lrvick"
#
## Example aliases
## alias zshconfig="mate ~/.zshrc"
## alias ohmyzsh="mate ~/.oh-my-zsh"
#
## Set to this to use case-sensitive completion
## CASE_SENSITIVE="true"
#
## Comment this out to disable bi-weekly auto-update checks
## DISABLE_AUTO_UPDATE="true"
#
## Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
## export UPDATE_ZSH_DAYS=13
#
## Uncomment following line if you want to disable colors in ls
## DISABLE_LS_COLORS="true"
#
## Uncomment following line if you want to disable autosetting terminal title.
## DISABLE_AUTO_TITLE="true"
#
## Uncomment following line if you want red dots to be displayed while waiting for completion
## COMPLETION_WAITING_DOTS="true"
#
## Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
## Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
## Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode docker pass systemdi z)
#

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

export QT_DEVICE_PIXEL_RATIO=auto

export GOPATH=~/.local/lib/go/

source $ZSH/oh-my-zsh.sh
source `pip2 show powerline-status | grep Location | sed 's/Location: //g'`/powerline/bindings/zsh/powerline.zsh

[ -f /home/lrvick/.travis/travis.sh ] && source /home/lrvick/.travis/travis.sh

[ -f ~/.device ] && source ~/.device # device specific settings kept out of version control
