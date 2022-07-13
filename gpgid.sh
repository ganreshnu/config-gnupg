#!/usr/bin/env bash
function gpgid() {
	read -r -d '' script <<-'EOF'
/\[A\]/ { f = 1; next }
f && /Keygrip/ {
	("gpgconf --list-dir homedir" | getline homedir)
	print $3 > homedir "/sshcontrol"
}
{ f = 0 }

sub(/^uid.*\] /, "", $0) {
	email = substr($(NF), 2, length($(NF))-2)
	NF-=1
	system("git config --global user.email " email)
	system("git config --global user.name '" $0 "'")
}
EOF

	gpg --list-keys --with-keygrip $1 | awk "$script"
}
gpgid $@
