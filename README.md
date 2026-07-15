# GnuPG Configuration

## Importing keys
gpg --import --batch <keyfile.asc>

## GnuPG as ssh-agent
gpg-connect-agent 'KEYATTR <keygrip> Use-for-ssh: true' /bye
