output "resource_group_names" {
  value = { for k, rg in azurerm_resource_group.this : k => rg.name }
}

output "resource_group_locations" {
  value = { for k, rg in azurerm_resource_group.this : k => rg.location }
}

output "resource_group_ids" {
  value = { for k, rg in azurerm_resource_group.this : k => rg.id }
}

output "container_app_id" {
  value = azurerm_container_app.api.id
}

output "container_app_fqdn" {
  value = azurerm_container_app.api.latest_revision_fqdn
}

output "static_web_app_default_hostname" {
  value = azurerm_static_web_app.client.default_host_name
}

output "static_web_app_api_key" {
  value     = azurerm_static_web_app.client.api_key
  sensitive = true
}

output "app_insights_connection_string" {
  value     = var.enable_app_insights ? azurerm_application_insights.api[0].connection_string : null
  sensitive = true
}

output "sql_server_fqdn" {
  value = var.enable_sql ? azurerm_mssql_server.this[0].fully_qualified_domain_name : null
}

output "sql_database_name" {
  value = var.enable_sql ? azurerm_mssql_database.this[0].name : null
}

output "storage_account_name" {
  value = var.enable_storage ? azurerm_storage_account.this[0].name : null
}

output "storage_account_primary_connection_string" {
  value     = var.enable_storage ? azurerm_storage_account.this[0].primary_connection_string : null
  sensitive = true
}

output "clerk_webhook_endpoint_url" {
  description = "Paste this into the Clerk Dashboard's Webhooks page as the endpoint URL — the provider can't set it directly."
  value       = "https://${azurerm_container_app.api.latest_revision_fqdn}/webhooks/clerk"
}
