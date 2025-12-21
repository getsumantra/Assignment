terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "711f9f70-1892-49fb-a04f-5bf2c5a89677"
}
