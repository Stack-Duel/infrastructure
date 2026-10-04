resource "azurerm_log_analytics_workspace" "api" {
  count               = var.enable_app_insights ? 1 : 0
  name                = "log-sdapi-${var.environment_key}-${var.primary_region_key}-${var.resource_name_suffix}"
  location            = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_in_days
}

resource "azurerm_application_insights" "api" {
  count                = var.enable_app_insights ? 1 : 0
  name                 = "appi-sdapi-${var.environment_key}-${var.primary_region_key}-${var.resource_name_suffix}"
  location             = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name  = azurerm_resource_group.this[var.primary_region_key].name
  workspace_id         = azurerm_log_analytics_workspace.api[0].id
  application_type     = "web"
  daily_data_cap_in_gb = var.daily_data_cap_in_gb
}

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
