resource "azurerm_resource_group" "amb_messagebroker_rg" {
  name     = "amb-messagebroker-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_servicebus_namespace" "amb_svcbus_ns" {
  name                          = "amb-svcbus-ns-${var.env_name}"
  location                      = azurerm_resource_group.amb_messagebroker_rg.location
  resource_group_name           = azurerm_resource_group.amb_messagebroker_rg.name
  sku                           = "Standard"
  local_auth_enabled            = false
  public_network_access_enabled = false
  minimum_tls_version           = "TLS1_2"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_servicebus_queue" "amb_queue_activate_customer" {
  name                  = "amb-queue-activate-customer-${var.env_name}"
  namespace_id          = azurerm_servicebus_namespace.amb_svcbus_ns.id
  max_size_in_megabytes = 1024
}

resource "azurerm_servicebus_queue" "amb_queue_deactivate_customer" {
  name                  = "amb-queue-deactivate-customer-${var.env_name}"
  namespace_id          = azurerm_servicebus_namespace.amb_svcbus_ns.id
  max_size_in_megabytes = 1024
}

resource "azurerm_servicebus_queue" "amb_queue_email_customer" {
  name                  = "amb-queue-email-customer-${var.env_name}"
  namespace_id          = azurerm_servicebus_namespace.amb_svcbus_ns.id
  max_size_in_megabytes = 1024
}

resource "azurerm_servicebus_topic" "amb_topic_customer_created" {
  name         = "amb-topic-customer-created-${var.env_name}"
  namespace_id = azurerm_servicebus_namespace.amb_svcbus_ns.id
}

resource "azurerm_servicebus_topic" "amb_topic_customer_updated" {
  name         = "amb-topic-customer-updated-${var.env_name}"
  namespace_id = azurerm_servicebus_namespace.amb_svcbus_ns.id
}

resource "azurerm_servicebus_topic" "amb_topic_region_added" {
  name         = "amb-topic-region-added-${var.env_name}"
  namespace_id = azurerm_servicebus_namespace.amb_svcbus_ns.id
}