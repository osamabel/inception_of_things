#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl

while [ ! -f /vagrant/shared/node-token ]; do
    echo "Waiting for node-token from master..."
    sleep 10
done

# Install K3s Agent - using the token directly in the command
curl -sfL https://get.k3s.io | \
K3S_URL="https://192.168.56.110:6443" \
K3S_TOKEN=$(cat /vagrant/shared/node-token) \
sh -s - --node-ip 192.168.56.111