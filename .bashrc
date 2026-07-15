export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(tty)

# alias iam="$HOME/.gnupg/gpgid.sh"

function gpg-keygrip() {
	gpg --list-keys --with-keygrip --with-colons "$@" |awk -F ':' '$12 == "a" { found = 1; next } found && /^grp/ { print $10; found = 0 }' 
}

function iam() {
	local ident_keygrip=${ gpg-keygrip "$*"; }
	if [[ ! "$ident_keygrip" ]]; then
		>&2 echo "error: unknown identity"
		return 1
	fi
	local ident=${ gpg --list-keys --with-colons "$*" |awk -F ':' '/^uid/ { print $10 }'; }
	git config --global user.email ${ echo "$ident" |awk -F'[<>]' '{ print $2 }'; }
	git config --global user.name "${ echo "$ident" |awk -F' <' '{ print $1 }'; }"

	# gpg --list-keys "$*" |awk '/^uid/ { for(i=3; i<NF; i++) name[length(name) + 1] = $i; }'
	gpg-keygrip |while IFS= read -r keygrip; do
		local priority=20
		if [[ "$keygrip" == "$ident_keygrip" ]]; then
			priority=1
		fi
		gpg-connect-agent "KEYATTR $keygrip Use-for-ssh: $priority" /bye >/dev/null
	done
}

# vim: ft=bash
