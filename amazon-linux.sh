#!/bin/bash
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>This is WebServer 01</h1></html>" > index.html

===================================================================================

curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash

sudo yum update -y
sudo yum install awslogs -y 
sudo yum install gitlab-runner -y

sudo amazon-linux-extras install docker -y
sudo amazon-linux-extras install postgresql10

sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo usermod -aG docker ec2-user
sudo usermod -aG docker gitlab-runner
sudo usermod -aG psql gitlab-runner

sudo service docker start
sudo gitlab-runner start

systemctl start awslogsd
systemctl enable awslogsd.service

sudo -u gitlab-runner -H docker info


