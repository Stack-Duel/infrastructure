resource "azurerm_mssql_server" "this" {
  count                        = var.enable_sql ? 1 : 0
  name                         = "sql-sd-${var.environment_key}-${var.primary_region_key}-${var.resource_name_suffix}"
  resource_group_name          = azurerm_resource_group.this[var.primary_region_key].name
  location                     = azurerm_resource_group.this[var.primary_region_key].location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  count            = var.enable_sql ? 1 : 0
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.this[0].id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "this" {
  count     = var.enable_sql ? 1 : 0
  name      = "sqldb-sd-${var.environment_key}-${var.resource_name_suffix}"
  server_id = azurerm_mssql_server.this[0].id

  sku_name    = "GP_S_Gen5_2"
  max_size_gb = var.sql_database_max_size_gb

  min_capacity                = var.sql_database_min_capacity
  auto_pause_delay_in_minutes = var.sql_database_auto_pause_delay_in_minutes

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azapi_update_resource" "sql_free_limit" {
  count       = var.enable_sql ? 1 : 0
  type        = "Microsoft.Sql/servers/databases@2023-08-01-preview"
  resource_id = azurerm_mssql_database.this[0].id

  body = {
    properties = {
      useFreeLimit                = true
      freeLimitExhaustionBehavior = "AutoPause"
    }
  }
}
