export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(tty)

alias iam="$HOME/.gnupg/gpgid.sh"

# vim: ft=bash
