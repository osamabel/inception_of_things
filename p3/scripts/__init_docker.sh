#!/bin/bash

# Define colors for logs
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
RED="\e[1;31m"
BLUE="\e[1;34m"
NC="\e[0m" # No Color

echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🐳 INSTALLING DOCKER ON DEBIAN       │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

# Check if Docker is already installed
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}📦 Docker not found. Installing Docker...${NC}"

    # Remove any old Docker versions
    sudo apt-get remove -y docker docker-engine docker.io containerd runc

    # Update system packages
    sudo apt-get update

    # Install required dependencies
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg

    # Add Docker’s official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add Docker repository for Debian
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update package index and install Docker
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add user to the Docker group
    sudo groupadd docker
    sudo usermod -aG docker $USER

    echo -e "${GREEN}✅ Docker installation completed successfully!${NC}"
    echo -e "${YELLOW}⚠️  Please log out and log back in for the changes to take effect.${NC}\n"
else
    echo -e "${GREEN}✅ Docker is already installed.${NC}\n"
fi

