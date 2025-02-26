#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl

# Install K3s Server
curl -sfL https://get.k3s.io | \
sh -s - --node-ip "192.168.56.110"

mkdir -p /vagrant/shared

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/shared/node-token
sudo chmod 644 /vagrant/shared/node-token