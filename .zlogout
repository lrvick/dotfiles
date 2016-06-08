# If connected remote
if [ ! -z "$SSH_TTY" ]; then
    # cleanup remote gpg agent socket
    [ -f ~/.gnupg/S.gpg-agent ] && rm ~/.gnupg/S.gpg-agent
fi
