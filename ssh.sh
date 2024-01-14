#--- SSH KeyGen: Helpful Commands ---#
ssh-keygen
ssh-keygen -o -a 100 -t ed25519 -f filename -C "user@device-id"     # create Ed25519 key
ssh-keygen -t rsa -b 4096 -f filename -C "user@device-id"           # create RSA 4096 key
ssh-keygen -y -f key.pem > key.pub                                  # create .pub key from private key

#--- SSH: Helpful Commands ---#
ssh -i my-key.pem -N -D <socks-tunnel-port> user-name@bastion.ip    # open SOCKS tunnel through bastion host
ssh -i my-key.pem user-name@destination.ip -o "proxycommand ssh -W %h:%p -i my-key.pem user-name@bastion.ip"    # create transparent SSH tunnel through bastion host

#--- Terminal: Helpful Commands ---#
sudo lsof -i -P -n | grep LISTEN                                    # see what ports have services listening
less filename.zip                                                   # see the list of contents in a .zip filename

openssl x509 -noout -fingerprint -[md5|sha1|sha256] -inform pem -in [certificate-file.crt]  # see a certificates thumbprint
echo -n "value" | openssl dgst -sha1 -hmac "key"
echo -n "value" | openssl sha1 -hmac "key"

