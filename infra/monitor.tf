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

# Commented out due to bug/limitation in building monitor
# https://github.com/hashicorp/terraform-provider-azurerm/issues/20944
# resource "azurerm_monitor_metric_alert" "amb_alert_queue_topic_volume_irregular" {
#   name                = "amb-alert-queue-topic-volume-irregular-${var.env_name}"
#   resource_group_name = azurerm_resource_group.amb_monitor_rg.name
#   scopes              = [azurerm_servicebus_namespace.amb_svcbus_ns.id]
#   description         = "Monitors if queue or topic volumes become irregular"

#   dynamic_criteria {
#     metric_namespace  = "microsoft.servicebus/namespaces"
#     metric_name       = "ActiveMessages"
#     aggregation       = "Average"
#     operator          = "GreaterOrLessThan"
#     alert_sensitivity = "High"

#     dimension {
#       name     = "EntityName"
#       operator = "Include"
#       values   = ["*"]
#     }
#   }

#   action {
#     action_group_id = azurerm_monitor_action_group.amb_monitor_group_main.id
#   }
# }