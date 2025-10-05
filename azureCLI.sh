#!/bin/bash
set -e

# ---------------------------
# Install Azure CLI (RHEL 9)
# ---------------------------
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo curl -o /etc/yum.repos.d/azure-cli.repo https://packages.microsoft.com/config/rhel/9/prod.repo
sudo yum install -y azure-cli

az version

# ---------------------------
# Install kubectl (latest stable)
# ---------------------------
KUBE_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO "https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# Fix PATH issue by symlinking into /usr/bin (which is already in PATH)
if [ ! -f /usr/bin/kubectl ]; then
  sudo ln -s /usr/local/bin/kubectl /usr/bin/kubectl
fi

kubectl version --client

# ---------------------------
# Connect to AKS cluster
# ---------------------------
az login
az account set --subscription "0aa6e6f6-6e44-47f7-b30d-2aa0dfd4e5f4"

# ⚠️ Replace RG and NAME with actual values from `az aks list`
az aks get-credentials --resource-group RG --name roboshop

# ---------------------------
# Verify cluster connection
# ---------------------------
kubectl get nodes
kubectl get pods -A

