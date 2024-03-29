resource "azurerm_resource_group" "amb_function_rg" {
  name     = "amb-function-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_storage_account" "amb_function_storage" {
  #checkov:skip=CKV_AZURE_190:Not supported in latest provider, set public_network_access_enabled argument instead
  #checkov:skip=CKV2_AZURE_18:Azure managed key acceptable for proof of concept build
  #checkov:skip=CKV2_AZURE_1:Azure managed key acceptable for proof of concept build
  #checkov:skip=CKV2_AZURE_33:VNet not part of proof of concept build, private endpoint not possible 
  name                          = "ambfunctionstorage${var.env_name}"
  resource_group_name           = azurerm_resource_group.amb_function_rg.name
  location                      = azurerm_resource_group.amb_function_rg.location
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

resource "azurerm_service_plan" "amb_email_function_plan" {
  #checkov:skip=CKV_AZURE_211:B1 plan suitable for proof of concept build
  #checkov:skip=CKV_AZURE_212:failover not required, proof of concept build uses basic license
  name                = "amb-email-function-plan-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_function_rg.name
  location            = azurerm_resource_group.amb_function_rg.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_linux_function_app" "amb_function" {
  for_each            = local.functions
  name                = each.key
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