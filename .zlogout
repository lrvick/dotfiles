# If connected remote
if [ ! -z "$SSH_TTY" ]; then
    # cleanup remote gpg agent socket
    [ -e ~/.gnupg/S.gpg-agent ] && rm ~/.gnupg/S.gpg-agent
fi
