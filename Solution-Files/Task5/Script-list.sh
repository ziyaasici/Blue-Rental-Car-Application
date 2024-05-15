sudo yum update
sudo yum install git -y
git clone https://ziyaasici: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@github.com/ziyaasici/Blue-Rental-Car-Application.git


# kubectl Kurulum
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

# aws configure
aws configure 

# Add Cluster
aws eks create-cluster --cli-input-json file://Blue-Rental-Car-Application/Solution-Files/Task5/EKS/cluster-config.json
aws eks describe-cluster --name "Blue-Car-Rental-EKS" --query "cluster.status"
# CHECK STATUS TO BE ACTIVE olduktan sonra
aws eks --region "us-east-1" update-kubeconfig --name "Blue-Car-Rental-EKS"


# Add NodeGroup
aws eks create-nodegroup --cli-input-json file://Blue-Rental-Car-Application/Solution-Files/Task5/EKS/nodegroup-config.json
aws eks describe-nodegroup --cluster-name "Blue-Car-Rental-EKS" --nodegroup-name "Blue-Car-Rental-NodeGroup" --query "nodegroup.status" # ACTIVE OLMASINI BEKLE

# Create s3 Bucket
aws s3 mb s3://ziyaasici-task5-blue-rental-car --region us-east-1
echo "" | aws s3 cp - s3://ziyaasici-task5-blue-rental-car/blue-rental-car/dummyfile

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm plugin install https://github.com/hypnoglow/helm-s3.git

# Create Charts in Task5 folder
helm create blue-rental-car
rm -rf templates/*
helm package ../blue-rental-car
helm repo index .

# S3 Repo Init
helm s3 init s3://ziyaasici-task5-blue-rental-car/blue-rental-car/

# Helm Repo Ekle
helm repo add blue-rental s3://ziyaasici-task5-blue-rental-car/blue-rental-car/

# Push to s3
helm s3 push ./blue-rental-car-0.1.0.tgz blue-rental

# Deploy
helm install app blue-rental/blue-rental-car