terraform {
  required_providers {
    azurerm = {
      # ...
    }
  }
  required_version = ">= 1.1.9"
}

# This block goes outside of the required_providers block!
provider "azurerm" {
  features {}
}


data "azurerm_storage_account" "example" {
  name                = "dlstorageaccountcdc00200"
  resource_group_name = "rg-cdc-adls-dev-01"
}

output "storage_account_tier" {
  value = data.azurerm_storage_account.example.account_tier
}