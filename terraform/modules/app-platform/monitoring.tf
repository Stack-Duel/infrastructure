resource "azurerm_monitor_action_group" "api" {
  count               = var.enable_alerts ? 1 : 0
  name                = "ag-sdapi-${var.environment_key}-${var.primary_region_key}-${var.resource_name_suffix}"
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  short_name          = substr("sdapi${var.environment_key}", 0, 12)

  dynamic "email_receiver" {
    for_each = var.contact_emails
    content {
      name                    = "email-${index(var.contact_emails, email_receiver.value)}"
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }
}

resource "azurerm_monitor_metric_alert" "http_5xx" {
  count               = var.enable_alerts && var.compute_type == "app_service" ? 1 : 0
  name                = "alert-sdapi-${var.environment_key}-${var.primary_region_key}-http5xx"
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  scopes              = [var.os_type == "Windows" ? azurerm_windows_web_app.api[0].id : azurerm_linux_web_app.api[0].id]
  description         = "Fires when the API returns a burst of HTTP 5xx responses."
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.api[0].id
  }
}

resource "azurerm_monitor_metric_alert" "response_time" {
  count               = var.enable_alerts && var.compute_type == "app_service" ? 1 : 0
  name                = "alert-sdapi-${var.environment_key}-${var.primary_region_key}-response-time"
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  scopes              = [var.os_type == "Windows" ? azurerm_windows_web_app.api[0].id : azurerm_linux_web_app.api[0].id]
  description         = "Fires when average response time stays elevated, which is also what a stuck DB/dependency connection looks like."
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.api[0].id
  }
}
