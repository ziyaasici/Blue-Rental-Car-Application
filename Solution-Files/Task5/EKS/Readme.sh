sudo yum update

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

aws configure #YAPILACAK JENKINS MAKINADA GEREK OLMAYABILIR ADMIN YETKISI OLDUGU ICIN


#### CREATE EKS CLUSTER
aws eks create-cluster --cli-input-json file://cluster-config.json
# WAIT FOR STATUS TO BE ACTIVE
aws eks describe-cluster --name "Blue-Car-Rental-EKS" --query "cluster.status" # BURADAN AKTIK DONDUGU ZAMAN
aws eks --region "us-east-1" update-kubeconfig --name "Blue-Car-Rental-EKS"


#### CREATE CLUSTER NODE GROUP
aws eks create-nodegroup --cli-input-json file://nodegroup-config.json
aws eks describe-nodegroup --cluster-name "Blue-Car-Rental-EKS" --nodegroup-name "Blue-Car-Rental-NodeGroup" --query "nodegroup.status" # ACTIVE OLMASINI BEKLE

sudo yum install git -y
git clone https://ziyaasici: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@github.com/ziyaasici/Blue-Rental-Car-Application.git

#Install HELM
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

#S3 Olustur
aws s3 mb s3://ziyaasici-task5-blue-rental-car --region us-east-1
echo "" | aws s3 cp - s3://ziyaasici-task5-blue-rental-car/blue-rental-car/dummyfile

#Install Helm Plugin
helm plugin install https://github.com/hypnoglow/helm-s3.git

# S3 Init
helm s3 init s3://ziyaasici-task5-blue-rental-car/blue-rental-car/

# Helm Repo Ekle
helm repo add stable-myapp s3://ziyaasici-task5-blue-rental-car/blue-rental-car/

# Helm
helm package ./Solution-Files/Task5/k8s