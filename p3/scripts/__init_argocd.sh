#!/bin/bash

# Define colors
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
RED="\e[1;31m"
NC="\e[0m" # No Color

# Step 6: Install Argo CD
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🚀 INSTALLING ARGO CD                │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

echo -e "${YELLOW}📥 Applying Argo CD manifests...${NC}"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo -e "${GREEN}✅ Argo CD installation initiated.${NC}\n"

# Wait for Argo CD to be ready
echo -e "${YELLOW}⏳ Waiting for Argo CD to be ready (this may take a few minutes)...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd
echo -e "${GREEN}✅ Argo CD is ready!${NC}\n"

# Step 7: Get the Argo CD admin password
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🔑 RETRIEVING ARGO CD PASSWORD       │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo -e "${GREEN}🔐 Argo CD Admin Password: ${ARGOCD_PASSWORD}${NC}\n"

# Step 8: Port forward to access Argo CD UI
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🌐 ACCESS ARGO CD UI                 │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

echo -e "${YELLOW}📌 To access Argo CD UI, run the following command in a new terminal:${NC}"
echo -e "${GREEN}kubectl port-forward svc/argocd-server -n argocd 8080:443${NC}"
echo -e "🔗 Then access Argo CD UI at: ${YELLOW}https://localhost:8080${NC}"
echo -e "👤 Username: ${GREEN}admin${NC}"
echo -e "🔑 Password: ${GREEN}(use the retrieved password above)${NC}\n"

# Step 9: Install Argo CD CLI (optional)
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🔧 INSTALLING ARGO CD CLI            │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

echo -e "${YELLOW}📥 Downloading Argo CD CLI...${NC}"
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x argocd-linux-amd64
sudo mv argocd-linux-amd64 /usr/local/bin/argocd
echo -e "${GREEN}✅ Argo CD CLI installed successfully!${NC}\n"

echo -e "\n${BLUE}🎉 Setup completed!${NC}"

