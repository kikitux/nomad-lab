#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# pre-reqs
apt-get update
apt-get install -y zip unzip

# hashicorp apt repo
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install nomad
apt-get update
apt-get install -y nomad
hash -r
nomad --autocomplete-install

# create directories
mkdir -p /opt/nomad
mkdir -p /etc/nomad.d

chmod 700 /opt/nomad
chmod 700 /etc/nomad.d

cp -ap /vagrant/conf/client/nomad.hcl /etc/nomad.d/
chown -R nomad: /etc/nomad.d /opt/nomad/

cp -ap /vagrant/conf/client/nomad.service /etc/systemd/system/

# nomad set bash env
cp -ap /vagrant/conf/client/nomad-bash-env.sh /etc/profile.d/

systemctl enable nomad
systemctl start nomad


