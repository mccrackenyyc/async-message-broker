resource "azurerm_resource_group" "amb_messagebroker_rg" {
  name     = "amb-messagebroker-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_servicebus_namespace" "amb_svcbus_ns" {
  #checkov:skip=CKV_AZURE_199:double encryption not required for proof of concept build
  #checkov:skip=CKV_AZURE_202:managed identity not required for proof of concept build
  #checkov:skip=CKV_AZURE_201:customer-managed key not required for proof of concept build
  name                          = "amb-svcbus-ns-${var.env_name}"
  location                      = azurerm_resource_group.amb_messagebroker_rg.location
  resource_group_name           = azurerm_resource_group.amb_messagebroker_rg.name
  sku                           = "Standard"
  local_auth_enabled            = false
  public_network_access_enabled = false
  minimum_tls_version           = 1.2

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_servicebus_queue" "amb_queue" {
  for_each              = local.queues.names
  name                  = each.key
  namespace_id          = azurerm_servicebus_namespace.amb_svcbus_ns.id
  max_size_in_megabytes = 1024
}

resource "azurerm_servicebus_topic" "amb_topic" {
  for_each     = local.topics.names
  name         = each.key
  namespace_id = azurerm_servicebus_namespace.amb_svcbus_ns.id
}