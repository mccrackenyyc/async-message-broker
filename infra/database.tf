resource "azurerm_resource_group" "amb_sql_rg" {
  name     = "amb-sql-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_storage_account" "amb_sql_logs" {
  #checkov:skip=CKV_AZURE_190:Not supported in latest provider, set public_network_access_enabled argument instead
  name                          = "ambsqllogs${var.env_name}"
  resource_group_name           = azurerm_resource_group.amb_sql_rg.name
  location                      = azurerm_resource_group.amb_sql_rg.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 100
    }
  }

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_mssql_server" "amb_sql_server" {
  name                          = "amb-sql-server-${var.env_name}"
  resource_group_name           = azurerm_resource_group.amb_sql_rg.name
  location                      = azurerm_resource_group.amb_sql_rg.location
  version                       = "12.0"
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  azuread_administrator {
    azuread_authentication_only = true
    login_username              = var.admin_upn
    object_id                   = data.azuread_user.admin.object_id
  }

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_mssql_database" "amb_sql_database" {
  name      = "amb-sql-database-${var.env_name}"
  server_id = azurerm_mssql_server.amb_sql_server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name  = "S0"

  tags = {
    tag = var.exampletag
  }
}