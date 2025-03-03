#!/bin/bash

# Define colors
GREEN="\e[1;32m"
BLUE="\e[1;34m"
NC="\e[0m" # No Color

echo -e "\n${BLUE}🚀 Running all initialization scripts...${NC}\n"

# Run each script in order
./scripts/__init_docker.sh && echo -e "${GREEN}✅ Docker setup completed.${NC}\n" || exit 1
./scripts/__init_k3d.sh && echo -e "${GREEN}✅ K3d setup completed.${NC}\n" || exit 1
./scripts/__init_kubectl.sh && echo -e "${GREEN}✅ Kubectl setup completed.${NC}\n" || exit 1
./scripts/__init_namespaces.sh && echo -e "${GREEN}✅ Namespaces setup completed.${NC}\n" || exit 1
./scripts/__init_argocd.sh && echo -e "${GREEN}✅ ArgoCD setup completed.${NC}\n" || exit 1

echo -e "${BLUE}🎉 All scripts executed successfully!${NC}"

