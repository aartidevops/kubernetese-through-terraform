terraform {
 backend "azurerm" {
   resource_group_name   = "RG"
   storage_account_name  = "rttfstatestorage"
   container_name        = "tfstate"
   key                   = "terraform.tfstate"
 }
}
