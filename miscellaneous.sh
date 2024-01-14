#--- Terminal: Helpful Commands ---#
sudo lsof -i -P -n | grep LISTEN                                    # see what ports have services listening
less filename.zip                                                   # see the list of contents in a .zip filename

#--- OpenSSL: Helpful Commands ---#
openssl req -new -key <key-file-path> -out <out-file-path.csr> -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=my-org.com" # request a certificate
openssl x509 -noout -fingerprint -[md5|sha1|sha256] -inform pem -in [certificate-file.crt]  # see a certificates thumbprint
openssl x509 -in [certificate-file.crt] -text -noout  # see a certificate's details
echo -n "value" | openssl dgst -sha1 -hmac "key"
echo -n "value" | openssl sha1 -hmac "key"

    # Create Kubernetes CA cert
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

    # Generate kube-admin client cert
openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -subj "/CN-kube-admin/O=system:masters" -out admin.csr
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt

sudo systemctl start pcscd.service # Start pscscd for ykman