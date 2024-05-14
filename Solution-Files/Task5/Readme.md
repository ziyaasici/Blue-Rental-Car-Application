sudo yum update
sudo yum install git -y
git clone #XXXXXXXXXXXXXX
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform


After terraform apply and EKS Cluster created;
- aws eks update-kubeconfig --name my-cluster