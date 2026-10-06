output "app_insights_connection_string" {
  value     = module.scrum.app_insights_connection_string
  sensitive = true
}

output "service_bus_connection_string" {
  value     = module.scrum.service_bus_connection_string
  sensitive = true
}

output "web_app_default_hostname" {
  value = module.scrum.web_app_default_hostname
}
