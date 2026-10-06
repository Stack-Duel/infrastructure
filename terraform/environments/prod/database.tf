resource "azurerm_postgresql_flexible_server" "prod" {
  name                = "psql-sdapi-prod-centralus-01"
  resource_group_name = module.prod.resource_group_names["centralus"]
  location            = module.prod.resource_group_locations["centralus"]

  version                = "16"
  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  storage_mb = 32768
  sku_name   = "B_Standard_B1ms"
  zone       = var.postgres_zone

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled = true
}

resource "azurerm_postgresql_flexible_server_database" "stackduel" {
  name      = "stackduel"
  server_id = azurerm_postgresql_flexible_server.prod.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "app_outbound" {
  for_each = toset(module.prod.web_app_possible_outbound_ips)

  name             = "allow-app-${replace(each.value, ".", "-")}"
  server_id        = azurerm_postgresql_flexible_server.prod.id
  start_ip_address = each.value
  end_ip_address   = each.value
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "migration_client" {
  count = local.migration_client_ip_set ? 1 : 0

  name             = "allow-migration-client"
  server_id        = azurerm_postgresql_flexible_server.prod.id
  start_ip_address = var.migration_client_ip
  end_ip_address   = var.migration_client_ip
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "developer_client" {
  count = local.developer_client_ip_set ? 1 : 0

  name             = "allow-developer-client"
  server_id        = azurerm_postgresql_flexible_server.prod.id
  start_ip_address = var.developer_client_ip
  end_ip_address   = var.developer_client_ip
}

locals {
  migration_client_ip_set = var.migration_client_ip != null && var.migration_client_ip != ""
  developer_client_ip_set = var.developer_client_ip != null && var.developer_client_ip != ""
  db_connection_string    = "Host=${azurerm_postgresql_flexible_server.prod.fqdn};Port=5432;Database=${azurerm_postgresql_flexible_server_database.stackduel.name};Username=${var.postgres_admin_username};Password=${var.postgres_admin_password};SSL Mode=Require;Trust Server Certificate=true"
}
