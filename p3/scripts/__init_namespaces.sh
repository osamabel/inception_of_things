# Define colors
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
RED="\e[1;31m"
NC="\e[0m" # No Color

# Step 5: Create namespaces
echo -e "\n${BLUE}┌───────────────────────────────────────────────┐${NC}"
echo -e   "${BLUE}│          📂 CREATING NAMESPACES               │${NC}"
echo -e   "${BLUE}└───────────────────────────────────────────────┘${NC}\n"

# Function to create a namespace if it doesn't already exist
create_namespace() {
    local ns=$1
    if kubectl get namespace "$ns" &>/dev/null; then
        echo -e "${GREEN}✅ Namespace '$ns' already exists. Skipping...${NC}"
    else
        echo -e "${YELLOW}📦 Creating namespace: $ns...${NC}"
        kubectl create namespace "$ns"
        echo -e "${GREEN}✅ Namespace '$ns' created successfully!${NC}\n"
    fi
}

# Create required namespaces
create_namespace "argocd"
create_namespace "dev"

