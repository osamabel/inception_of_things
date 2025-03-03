#!/bin/bash

# Define colors
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
RED="\e[1;31m"
NC="\e[0m" # No Color

# Step 2: Install K3d
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🚀 INSTALLING K3D                    │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

echo -e "${YELLOW}📥 Downloading and installing K3d...${NC}"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo -e "${GREEN}✅ K3d installed successfully!${NC}\n"

# Step 3: Create a K3d cluster
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🏗️  CREATING K3D CLUSTER             │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

echo -e "${YELLOW}🔄 Creating a new K3d cluster...${NC}"
k3d cluster create my-cluster --api-port 6550 -p "8888:80@loadbalancer" --agents 2
echo -e "${GREEN}✅ K3d cluster created successfully!${NC}\n"

