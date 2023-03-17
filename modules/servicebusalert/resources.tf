resource "azurerm_monitor_metric_alert" "amb_alert_queue_topic_volume_irregular" {
  name                = "amb-alert-${var.type}-volume-irregular-${var.env_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.scope]
  severity            = var.severity
  description         = "Monitors if queue or topic volumes becomes overloaded which may indicate issues with processing"

  criteria {
    metric_namespace = "microsoft.servicebus/namespaces"
    metric_name      = "ActiveMessages"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.threshold

    dimension {
      name     = "EntityName"
      operator = "Include"
      values   = var.dimension_values
    }
  }

  action {
    action_group_id = var.action_group_id
  }
}