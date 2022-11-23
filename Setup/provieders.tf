terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }


  }
  backend "azurerm" {

    storage_account_name = "tfstate4global"
    container_name       = "global-tfstate"
    key                  = "Tean_Name-terraform.tfstate"
    resource_group_name  = "terraform"
    subscription_id      = "e0cc7faf-3760-4b0c-a9df-fecf8d900589"


  }
}

provider "azurerm" {
  features {}
}

