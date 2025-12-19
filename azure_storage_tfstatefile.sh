#Create a Resource Group

az group create --name RG --location ukwest

az storage account create \
  --name rttfstatestorage \
  --resource-group RG \
  --location ukwest \
  --sku Standard_LRS

  az storage container create \
      --name tfstate \
      --account-name rttfstatestorage \
      --auth-mode login







#Configure Terraform Backend
#In your Terraform project (in IntelliJ), add a backend block inside provider.tf (or create a new backend.tf):
#terraform {
#  backend "azurerm" {
#    resource_group_name   = "RG"
#    storage_account_name  = "rttfstatestorage"
#    container_name        = "tfstate"
#    key                   = "terraform.tfstate"
#  }
#}
