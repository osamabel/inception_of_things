#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl

# Install K3s Server
curl -sfL https://get.k3s.io | \
sh -s - --write-kubeconfig-mode 644 --node-ip "192.168.56.110"

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/k3s_token.txt
