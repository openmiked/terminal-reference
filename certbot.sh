# Install Certbot
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get -y update
sudo apt-get -y install certbot
# Create cert
sudo certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --email admin@donohue.engineering \
  --domains vpn.donohue.services \
  --pre-hook 'sudo service openvpnas stop' \
  --post-hook 'sudo service openvpnas start'
# Assume root
sudo su
# Create cert bundle, register all certs with OpenVPN, and restart the service
cat /etc/letsencrypt/live/vpn.donohue.services/fullchain.pem /etc/letsencrypt/live/vpn.donohue.services/privkey.pem > /etc/letsencrypt/live/vpn.donohue.services/bundle.pem
/usr/local/openvpn_as/scripts/sacli --key "cs.priv_key" --value_file "/etc/letsencrypt/live/vpn.donohue.services/privkey.pem" ConfigPut
/usr/local/openvpn_as/scripts/sacli --key "cs.cert" --value_file "/etc/letsencrypt/live/vpn.donohue.services/fullchain.pem" ConfigPut
/usr/local/openvpn_as/scripts/sacli --key "cs.ca_bundle" --value_file "/etc/letsencrypt/live/vpn.donohue.services/bundle.pem" ConfigPut
/usr/local/openvpn_as/scripts/sacli start

#========================================#

# Install Certbot
sudo ln -s -f /etc/letsencrypt/live/vpn.donohue.services/cert.pem /usr/local/openvpn_as/etc/web-ssl/server.crt
sudo ln -s -f /etc/letsencrypt/live/vpn.donohue.services/privkey.pem /usr/local/openvpn_as/etc/web-ssl/server.key

# Install Certbot
certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --email admin@aggregatesingularity.com \
  --domains gitlab.donohue.services

# Install Certbot
certbot certonly --force-renew -d vpn.donohue.services
sudo cat /etc/letsencrypt/live/vpn.donohue.services/fullchain.pem /etc/letsencrypt/live/vpn.donohue.services/privkey.pem > /etc/letsencrypt/live/vpn.donohue.services/bundle.pem
/usr/local/openvpn_as/scripts/sacli --key "cs.priv_key" --value_file "/etc/letsencrypt/live/vpn.donohue.services/privkey.pem" ConfigPut
/usr/local/openvpn_as/scripts/sacli --key "cs.cert" --value_file "/etc/letsencrypt/live/vpn.donohue.services/fullchain.pem" ConfigPut
/usr/local/openvpn_as/scripts/sacli --key "cs.ca_bundle" --value_file "/etc/letsencrypt/live/vpn.donohue.services/bundle.pem" ConfigPut
/usr/local/openvpn_as/scripts/sacli start



sudo apt-get install -y curl vim libltdl7 python3 python3-pip python software-properties-common unattended-upgrades
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get -y update
sudo apt-get -y install python-certbot certbot
sudo service openvpnas stop

sudo certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --email ${var.certificate_email} \
  --domains ${var.subdomain_name} \
  --pre-hook 'service openvpnas stop' \
  --post-hook 'service openvpnas start'

sudo ln -s -f /etc/letsencrypt/live/${var.subdomain_name}/cert.pem /usr/local/openvpn_as/etc/web-ssl/server.crt
sudo ln -s -f /etc/letsencrypt/live/${var.subdomain_name}/privkey.pem /usr/local/openvpn_as/etc/web-ssl/server.key
sudo service openvpnas start