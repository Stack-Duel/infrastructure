output "container_app_fqdn" {
  value = module.scrum.container_app_fqdn
}

output "static_web_app_default_hostname" {
  value = module.scrum.static_web_app_default_hostname
}

output "static_web_app_api_key" {
  value     = module.scrum.static_web_app_api_key
  sensitive = true
}

output "app_insights_connection_string" {
  value     = module.scrum.app_insights_connection_string
  sensitive = true
}

output "sql_server_fqdn" {
  value = module.scrum.sql_server_fqdn
}

output "storage_account_name" {
  value = module.scrum.storage_account_name
}

output "clerk_webhook_endpoint_url" {
  description = "Paste this into the Clerk Dashboard's Webhooks page — the provider can't set it directly."
  value       = module.scrum.clerk_webhook_endpoint_url
}
