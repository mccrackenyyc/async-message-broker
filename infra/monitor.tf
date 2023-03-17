resource "azurerm_resource_group" "amb_monitor_rg" {
  name     = "amb-monitor-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_monitor_action_group" "amb_monitor_group_main" {
  name                = "amb-monitor-action-group-main-${var.env_name}"
  resource_group_name = azurerm_resource_group.amb_monitor_rg.name
  short_name          = "monitor-${var.env_name}"

  email_receiver {
    name          = "monitor-email"
    email_address = "smccracken@live.ca"
  }
}

module "service_bus_alerts" {
  for_each            = merge({ topics = local.topics }, { queues = local.queues })
  source              = "../modules/servicebusalert"
  env_name            = var.env_name
  resource_group_name = azurerm_resource_group.amb_monitor_rg.name
  scope               = azurerm_servicebus_namespace.amb_svcbus_ns.id
  dimension_values    = keys(each.value.names)
  action_group_id     = azurerm_monitor_action_group.amb_monitor_group_main.id
  threshold           = each.value.threshold
  type                = each.key
  severity            = each.value.severity
}