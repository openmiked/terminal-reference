#--- GPG: Helpful Commands ---#
export GPG_TTY=$(tty)
gpg --gen-key
gpg --list-keys
gpg --output key.gpg --export user@org.com # Export public key
gpg --output public-key-binary.gpg --export user@place.com