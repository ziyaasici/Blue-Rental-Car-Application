#!/bin/bash

# Set the NodePort values for each service
ui_nodeport=31000
app_nodeport=32000

# Convert Docker Compose file to Kubernetes manifests
kompose convert -f ../docker-compose.yml

# Loop through each generated Kubernetes manifest file
for file in *.yaml; do
    # Set NodePort for UI service
    if grep -q "ui:" "$file"; then
        sed -i "/name: ui/,/type: ClusterIP/ s/type: ClusterIP/type: NodePort\n      nodePort: $ui_nodeport/" "$file"
        ((ui_nodeport++))
    fi
    
    # Set NodePort for app service
    if grep -q "app:" "$file"; then
        sed -i "/name: app/,/type: ClusterIP/ s/type: ClusterIP/type: NodePort\n      nodePort: $app_nodeport/" "$file"
        ((app_nodeport++))
    fi
done