#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl

# Install K3s Server
curl -sfL https://get.k3s.io | \
sh -s - --node-ip "192.168.56.110" --write-kubeconfig-mode 644
# sudo /usr/local/bin/kubectl -n kube-system apply -f /vagrant/confs