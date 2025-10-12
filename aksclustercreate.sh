# ---------------------------
# Connect to AKS cluster
# ---------------------------
az login
az account set --subscription "0aa6e6f6-6e44-47f7-b30d-2aa0dfd4e5f4"

# ⚠️ Replace RG and NAME with actual values from `az aks list`
az aks get-credentials --resource-group RG --name aks-cluster

# ---------------------------
# Verify cluster connection
# ---------------------------
kubectl get nodes
kubectl get pods -A

