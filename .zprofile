# Arch Linux loads /etc/profile -after- .zshenv thus overwriting it
# See: https://wiki.archlinux.org/index.php/Zsh#Configuring_.24PATH

# Lets try this again here in .zprofile which we know loads after /etc/profile
source $HOME/.zshenv
