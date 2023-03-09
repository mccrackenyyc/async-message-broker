resource "azurerm_resource_group" "amb_function_rg" {
  name     = "amb-function-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_storage_account" "amb_function_storage" {
  name                          = "ambfunctionstorage${var.env_name}"
  resource_group_name           = azurerm_resource_group.amb_function_rg.name
  location                      = azurerm_resource_group.amb_function_rg.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
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

resource "azurerm_service_plan" "amb_email_function_plan" {
  name                = "amb-email-function-plan-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_function_rg.name
  location            = azurerm_resource_group.amb_function_rg.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_linux_function_app" "amb_function_send_email" {
  name                = "amb-function-send-email-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_function_rg.name
  location            = azurerm_resource_group.amb_function_rg.location

  storage_account_name       = azurerm_storage_account.amb_function_storage.name
  storage_account_access_key = azurerm_storage_account.amb_function_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.amb_email_function_plan.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
}

resource "azurerm_linux_function_app" "amb_function_update_customer_records" {
  name                = "amb-function-update-customer-records-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_function_rg.name
  location            = azurerm_resource_group.amb_function_rg.location

  storage_account_name       = azurerm_storage_account.amb_function_storage.name
  storage_account_access_key = azurerm_storage_account.amb_function_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.amb_email_function_plan.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
}