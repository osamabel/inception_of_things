#!/bin/bash

# Title banner
echo -e "\n\e[1;34m┌─────────────────────────────────────────────────┐\e[0m"
echo -e "\e[1;34m│           K3s INSTALLATION SCRIPT                │\e[0m"
echo -e "\e[1;34m└─────────────────────────────────────────────────┘\e[0m\n"

# Update system
echo -e "\e[1;33m🔄 Step 1/3: Updating system packages...\e[0m"
echo -e "  \e[36m➜ Running apt-get update...\e[0m"
if sudo apt-get update > /dev/null 2>&1; then
    echo -e "  \e[32m✓ System updated successfully\e[0m"
else
    echo -e "  \e[31m✗ System update failed\e[0m"
fi

# Install dependencies
echo -e "\n\e[1;33m📦 Step 2/3: Installing dependencies...\e[0m"
echo -e "  \e[36m➜ Installing curl...\e[0m"
if sudo apt-get install -y curl > /dev/null 2>&1; then
    echo -e "  \e[32m✓ Curl installed successfully\e[0m"
else
    echo -e "  \e[31m✗ Curl installation failed\e[0m"
fi

# Install K3s Server
echo -e "\n\e[1;33m🚀 Step 3/3: Installing K3s Server...\e[0m"
echo -e "  \e[36m➜ Setting up with node IP: 192.168.56.110\e[0m"
echo -e "  \e[36m➜ Kubeconfig will be readable by non-root users (mode 644)\e[0m"
echo -e "  \e[36m➜ Running K3s installer...\e[0m"

# Run K3s installer
curl -sfL https://get.k3s.io | \
sh -s - --node-ip "192.168.56.110" --write-kubeconfig-mode 644

# Final confirmation
if [ $? -eq 0 ]; then
  echo -e "\n\e[1;32m✅ K3s installation completed successfully!\e[0m"
  echo -e "\e[32m➜ Kubernetes server is now running on this node\e[0m"
  echo -e "\e[32m➜ Kubeconfig is available at /etc/rancher/k3s/k3s.yaml\e[0m\n"
else
  echo -e "\n\e[1;31m❌ K3s installation failed!\e[0m"
  echo -e "\e[31m➜ Please check the error messages above\e[0m\n"
  exit 1
fi

# Wait a moment for services to start
echo -e "\n\e[1;33m⏳ Waiting for all system pods to start...\e[0m"
for i in {1..10}; do
    echo -e "  \e[36m➜ Waiting... $i/10\e[0m"
    sleep 1
done

# Show running pods
echo -e "\n\e[1;36m📊 Cluster Status:\e[0m"
echo -e "  \e[36m➜ Node information:\e[0m"
sudo k3s kubectl get nodes -o wide
echo -e "\n  \e[36m➜ System pods:\e[0m"
sudo k3s kubectl get pods -A

echo -e "\n\e[1;34m┌─────────────────────────────────────────────────┐\e[0m"
echo -e "\e[1;34m│       K3s IS READY FOR APPLICATION DEPLOYMENT    │\e[0m"
echo -e "\e[1;34m└─────────────────────────────────────────────────┘\e[0m\n"