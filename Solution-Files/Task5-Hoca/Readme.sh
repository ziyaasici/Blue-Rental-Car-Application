- # git clone
git clone xxxx@repoURL

- # eksctl Kurulum
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

- # kubectl Kurulum
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

- # Helm Kurulum
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version

- # Helm S3 Plugin Kurulum
helm plugin install https://github.com/hypnoglow/helm-s3.git
helm plugin ls

- # jenkins usera gec
sudo su - jenkins -s /bin/bash

- # Cluster Olusturmak icin yaml olustur
touch cluster.yaml
nano cluster.yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: carrental-cluster
  region: us-east-1
availabilityZones: ["us-east-1a", "us-east-1b", "us-east-1c"]
managedNodeGroups:
  - name: brc-1
    instanceType: t3a.medium
    desiredCapacity: 2
    minSize: 2
    maxSize: 2
    volumeSize: 8
---

- # eksctl ile Cluster Olustur 
# (Bunu yaparken terminali sizden aliyor tamamlanana kadar)
eksctl create cluster -f cluster.yaml 
eksctl get cluster --region us-east-1
exit # ec2-user'a don

- # Helm Chart Olustur
helm create brc_chart
rm -rf brc_chart/templates/*

- # Manifest dosyalarini /brc_chart/template altina kopyala ve duzenle

- # S3 Bucket Olustur
aws s3 mb s3://brc-ziyaasici --region us-east-1

- # S3 Bucket Initialize et
helm s3 init s3://brc-ziyaasici/stable/myapp

- # Helm Repo Ekle
helm repo add blue-rental s3://brc-ziyaasici/stable/myapp
helm repo ls

- # Helm Package before push
helm package brc_chart/

- # Heml Push to S3 
helm s3 push ./brc_chart-0.1.0.tgz blue-rental

- # Prometheus ve Grafana icin ingress.yaml olustur ve duzenle

- # wait.sh duzenle (nginx ingresslerin podlarin durumunu check etmesi icin)

- # Jenkins Console Configure et

- # Build