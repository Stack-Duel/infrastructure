output "resource_group_names" {
  value = { for k, rg in azurerm_resource_group.this : k => rg.name }
}

output "resource_group_locations" {
  value = { for k, rg in azurerm_resource_group.this : k => rg.location }
}

output "resource_group_ids" {
  value = { for k, rg in azurerm_resource_group.this : k => rg.id }
}

output "web_app_id" {
  value = (
    var.compute_type == "container_app" ? azurerm_container_app.api[0].id :
    var.os_type == "Windows" ? azurerm_windows_web_app.api[0].id :
    azurerm_linux_web_app.api[0].id
  )
}

output "web_app_default_hostname" {
  value = (
    var.compute_type == "container_app" ? azurerm_container_app.api[0].latest_revision_fqdn :
    var.os_type == "Windows" ? azurerm_windows_web_app.api[0].default_hostname :
    azurerm_linux_web_app.api[0].default_hostname
  )
}

output "web_app_possible_outbound_ips" {
  value = (
    var.compute_type == "container_app" ? null :
    var.os_type == "Windows" ? azurerm_windows_web_app.api[0].possible_outbound_ip_address_list :
    azurerm_linux_web_app.api[0].possible_outbound_ip_address_list
  )
}

output "app_insights_connection_string" {
  value     = var.enable_app_insights ? azurerm_application_insights.api[0].connection_string : null
  sensitive = true
}

output "service_bus_connection_string" {
  value     = var.enable_service_bus ? azurerm_servicebus_namespace_authorization_rule.api[0].primary_connection_string : null
  sensitive = true
}

output "servicebus_namespace_id" {
  value = var.enable_service_bus ? azurerm_servicebus_namespace.this[0].id : null
}
