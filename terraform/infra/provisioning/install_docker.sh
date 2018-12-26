!#/bin/bash

apt-get -y remove docker docker-engine docker.io
apt-get update

apt install -y  apt-transport-https ca-certificates curl gnupg2 software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

apt-get update
apt-get -y install docker-ce

systemctl start docker
systemctl enable docker
