#!/bin/bash

# Set the NodePort values for each service
ui_nodeport=31000
app_nodeport=32000

# Loop through each generated Kubernetes manifest file
for file in *.yaml; do
    # Set NodePort for UI service
    if grep -q "io.kompose.service: ui" "$file"; then
        # Add the NodePort type correctly
        sed -i "/ports:/a \ \ type: NodePort" "$file"
        # Add the nodePort value under the correct port with the correct indentation
        sed -i "/- name: \"3000\"/a \ \ \ \ nodePort: $ui_nodeport" "$file"
        ((ui_nodeport++))  # Increment after modifications are done
    fi
    
    # Set NodePort for app service
    if grep -q "io.kompose.service: app" "$file"; then
        # Add the NodePort type correctly
        sed -i "/ports:/a \ \ type: NodePort" "$file"
        # Add the nodePort value under the correct port with the correct indentation
        sed -i "/- name: \"8080\"/a \ \ \ \ nodePort: $app_nodeport" "$file"
        ((app_nodeport++))  # Increment after modifications are done
    fi
done
