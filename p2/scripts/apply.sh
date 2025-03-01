#!/bin/bash

if [ ! -d "/home/vagrant/confs" ]; then
    echo -e "\n\e[1;32m┌─────────────────────────────────────────────────┐\e[0m"
    echo -e "\e[1;32m│ Using local copy of configuration files...        │\e[0m"
    echo -e "\e[1;32m└─────────────────────────────────────────────────┘\e[0m\n"
    
    # Apply ConfigMaps first
    echo -e "\e[1;34m⚙️  Step 1/4: Applying ConfigMaps...\e[0m"
    for file in /home/vagrant/confs/Apps/*.yaml; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo -e "  \e[36m➜ Applying $filename\e[0m"
            if sudo k3s kubectl apply -f "$file"; then
                echo -e "    \e[32m✓ Success\e[0m"
            else
                echo -e "    \e[31m✗ Failed\e[0m"
            fi
        fi
    done
    echo -e "\e[1;32m✓ ConfigMaps applied successfully\e[0m\n"
    
    # Then apply Deployments
    echo -e "\e[1;34m⚙️  Step 2/4: Applying Deployments...\e[0m"
    for file in /home/vagrant/confs/Deplyoment/*.yaml; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo -e "  \e[36m➜ Applying $filename\e[0m"
            if sudo k3s kubectl apply -f "$file"; then
                echo -e "    \e[32m✓ Success\e[0m"
            else
                echo -e "    \e[31m✗ Failed\e[0m"
            fi
        fi
    done
    echo -e "\e[1;32m✓ Deployments applied successfully\e[0m\n"
    
    # Apply Services
    echo -e "\e[1;34m⚙️  Step 3/4: Applying Services...\e[0m"
    for file in /home/vagrant/confs/services/*.yaml; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo -e "  \e[36m➜ Applying $filename\e[0m"
            if sudo k3s kubectl apply -f "$file"; then
                echo -e "    \e[32m✓ Success\e[0m"
            else
                echo -e "    \e[31m✗ Failed\e[0m"
            fi
        fi
    done
    echo -e "\e[1;32m✓ Services applied successfully\e[0m\n"
    
    # Finally apply Ingress
    echo -e "\e[1;34m⚙️  Step 4/4: Applying Ingress...\e[0m"
    for file in /home/vagrant/confs/Ingress/*.yaml; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo -e "  \e[36m➜ Applying $filename\e[0m"
            if sudo k3s kubectl apply -f "$file"; then
                echo -e "    \e[32m✓ Success\e[0m"
            else
                echo -e "    \e[31m✗ Failed\e[0m"
            fi
        fi
    done
    echo -e "\e[1;32m✓ Ingress applied successfully\e[0m\n"
    
    echo -e "\e[1;32m┌─────────────────────────────────────────────────┐\e[0m"
    echo -e "\e[1;32m│ Configuration applied from local copy!          │\e[0m"
    echo -e "\e[1;32m└─────────────────────────────────────────────────┘\e[0m\n"
else
    echo -e "\n\e[1;31m⚠️  Synced folder not found. Creating local copy...\e[0m\n"
fi