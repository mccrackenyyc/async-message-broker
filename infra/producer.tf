resource "azurerm_resource_group" "amb_appsvc_rg" {
  name     = "amb-appsvc-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_service_plan" "amb_customer_processor_service_plan" {
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
  name                = "amb-customer-processor-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_appsvc_rg.name
  location            = azurerm_service_plan.amb_customer_processor_service_plan.location
  service_plan_id     = azurerm_service_plan.amb_customer_processor_service_plan.id

  site_config {}
}