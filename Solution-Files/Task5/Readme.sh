sudo yum update

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

sudo yum install git -y
git clone #XXXXXXXXXXXXXX

aws configure #YAPILACAK JENKINS MAKINADA GEREK OLMAYABILIR ADMIN YETKISI OLDUGU ICIN


#### CREATE EKS CLUSTER
aws eks create-cluster --cli-input-json file://cluster-config.json
# WAIT FOR STATUS TO BE ACTIVE
aws eks describe-cluster --name "Blue-Car-Rental-EKS" --query "cluster.status" # BURADAN AKTIK DONDUGU ZAMAN
aws eks --region "us-east-1" update-kubeconfig --name "Blue-Car-Rental-EKS"


#### CREATE CLUSTER NODE GROUP
aws eks create-nodegroup --cli-input-json file://nodegroup-config.json
aws eks describe-nodegroup --cluster-name "Blue-Car-Rental-EKS" --nodegroup-name "Blue-Car-Rental-NodeGroup" --query "nodegroup.status" # ACTIVE OLMASINI BEKLE



sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
