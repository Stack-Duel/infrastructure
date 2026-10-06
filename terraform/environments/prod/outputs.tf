output "db_connection_string" {
  value     = local.db_connection_string
  sensitive = true
}

output "app_insights_connection_string" {
  value     = module.prod.app_insights_connection_string
  sensitive = true
}

output "service_bus_connection_string" {
  value     = module.prod.service_bus_connection_string
  sensitive = true
}

output "web_app_default_hostname" {
  value = module.prod.web_app_default_hostname
}

output "github_migrator_client_id" {
  value = azurerm_user_assigned_identity.github_migrator.client_id
}

output "github_migrator_tenant_id" {
  value = azurerm_user_assigned_identity.github_migrator.tenant_id
}

output "postgres_server_name" {
  value = azurerm_postgresql_flexible_server.prod.name
}

output "postgres_resource_group" {
  value = module.prod.resource_group_names["centralus"]
}
