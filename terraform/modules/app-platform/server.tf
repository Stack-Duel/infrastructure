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

resource "azurerm_servicebus_namespace" "this" {
  count               = var.enable_service_bus ? 1 : 0
  name                = "sbns-sd-${var.environment_key}-${var.primary_region_key}-${var.service_bus_name_suffix}"
  location            = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  sku                 = var.service_bus_sku
}

resource "azurerm_servicebus_namespace_authorization_rule" "api" {
  count        = var.enable_service_bus ? 1 : 0
  name         = "api-send-listen"
  namespace_id = azurerm_servicebus_namespace.this[0].id
  listen       = true
  send         = true
  manage       = false
}

resource "azurerm_servicebus_queue" "this" {
  for_each     = var.enable_service_bus ? toset(var.service_bus_queue_names) : []
  name         = each.value
  namespace_id = azurerm_servicebus_namespace.this[0].id
}
