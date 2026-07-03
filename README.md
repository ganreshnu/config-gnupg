# GnuPG Configuration

## Importing keys
gpg --import --batch <keyfile.asc>

gpg-connect-agent 'KEYATTR <keygrip> Use-for-ssh: true /bye'
