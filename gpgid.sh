#!/usr/bin/env bash
function idssh() {
   gpg --list-keys --with-keygrip $1 | awk '/\[A\]/ { f = 1; next } f && /Keygrip/ { print $3 } { f = 0 }' > $GNUPGHOME/sshcontrol
}
idssh $@
