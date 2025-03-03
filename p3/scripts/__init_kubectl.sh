# Define colors
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
RED="\e[1;31m"
NC="\e[0m" # No Color

# Step 4: Install kubectl (if not already installed)
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          🔧 INSTALLING KUBECTL                 │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

if ! command -v kubectl &> /dev/null; then
    echo -e "${YELLOW}📥 kubectl not found. Installing...${NC}"

    # Download kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    # Make it executable
    chmod +x kubectl

    # Move it to /usr/local/bin
    sudo mv kubectl /usr/local/bin/

    echo -e "${GREEN}✅ kubectl installed successfully!${NC}\n"
else
    echo -e "${GREEN}✅ kubectl is already installed. Skipping installation.${NC}\n"
fi

