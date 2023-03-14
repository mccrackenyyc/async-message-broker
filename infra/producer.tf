resource "azurerm_resource_group" "amb_appsvc_rg" {
  name     = "amb-appsvc-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_service_plan" "amb_customer_processor_service_plan" {
  #checkov:skip=CKV_AZURE_211:B1 plan suitable for proof of concept build
  #checkov:skip=CKV_AZURE_212:failover not required, proof of concept build uses basic license
  name                = "amb-customer-processor-plan-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_appsvc_rg.name
  location            = azurerm_resource_group.amb_appsvc_rg.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_linux_web_app" "amb_customer_processor" {
  #checkov:skip=CKV_AZURE_17:client certificates not required for proof of concept build
  #checkov:skip=CKV_AZURE_88:Azure storage not required for proof of concept build
  name                = "amb-customer-processor-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_appsvc_rg.name
  location            = azurerm_service_plan.amb_customer_processor_service_plan.location
  service_plan_id     = azurerm_service_plan.amb_customer_processor_service_plan.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true
    http_logs {
      file_system {
        retention_in_days = 100
        retention_in_mb   = 100
      }
    }
  }
  auth_settings {
    enabled = true
  }

  site_config {
    ftps_state                        = "FtpsOnly"
    http2_enabled                     = true
    health_check_path                 = "/"
    health_check_eviction_time_in_min = 5
  }
}