terraform {
  backend "azurerm" {
    subscription_id      = "20c17ce1-c880-4374-ab18-0c3a72158cf7"
    resource_group_name  = "amb-statefile"
    storage_account_name = "mccrackenyycambstatefile"
    container_name       = "terraform"
    key                  = "amb.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.46.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.36.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

provider "azuread" {
  tenant_id = var.tenant_id
}