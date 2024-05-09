#!/bin/bash

# Set the NodePort values for each service
ui_nodeport=31000
app_nodeport=32000

# Loop through each generated Kubernetes manifest file
for file in *.yaml; do
    # Set NodePort for UI service
    if grep -q "io.kompose.service: ui" "$file"; then
        # Correctly place the type: NodePort under spec, not under ports
        sed -i "/spec:/a \ \ type: NodePort" "$file"
        # Correctly insert the nodePort value with proper indentation
        sed -i "/targetPort: \"3000\"/a \ \ \ \ nodePort: $ui_nodeport" "$file"
        ((ui_nodeport++))  # Increment after modifications are done
    fi
    
    # Set NodePort for app service
    if grep -q "io.kompose.service: app" "$file"; then
        # Correctly place the type: NodePort under spec, not under ports
        sed -i "/spec:/a \ \ type: NodePort" "$file"
        # Correctly insert the nodePort value with proper indentation
        sed -i "/targetPort: \"8080\"/a \ \ \ \ nodePort: $app_nodeport" "$file"
        ((app_nodeport++))  # Increment after modifications are done
    fi
done
