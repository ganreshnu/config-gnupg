#!/usr/bin/awk -f

/\[A\]/ {
	f = 1; next
}
f && /Keygrip/ {
	print $3 >  ENVIRON["GNUPGHOME"] "/sshcontrol"
}
{ f = 0 }

sub(/^uid.*\] /, "", $0) {
	email = $(NF)
	system("git config --global user.email " substr(email, 2, length(email)-2))
	NF-=1
	system("git config --global user.name '" $0 "'")
}
