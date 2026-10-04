resource "azurerm_static_web_app" "client" {
  name                = "stapp-sdclient-${var.environment_key}-${var.client_region_key}-${var.resource_name_suffix}"
  resource_group_name = azurerm_resource_group.this[var.client_region_key].name
  location            = azurerm_resource_group.this[var.client_region_key].location
  sku_tier            = var.static_web_app_sku_tier
  sku_size            = var.static_web_app_sku_size
}
