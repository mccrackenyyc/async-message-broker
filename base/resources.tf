resource "azurerm_resource_group" "amb_statefile" {
  name     = "amb-statefile"
  location = "Canada Central"
}

resource "azurerm_storage_account" "amb_statefile" {
  name                     = "mccrackenyycambstatefile"
  resource_group_name      = azurerm_resource_group.amb_statefile.name
  location                 = azurerm_resource_group.amb_statefile.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "exampletag"
  }
}

resource "azurerm_storage_container" "amb_terraform" {
  name                  = "terraform"
  storage_account_name  = azurerm_storage_account.amb_statefile.name
  container_access_type = "private"
}