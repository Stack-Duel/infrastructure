resource "azurerm_storage_account" "this" {
  count                           = var.enable_storage ? 1 : 0
  name                            = "stsd${var.environment_key}${var.primary_region_key}${var.storage_account_name_suffix}"
  location                        = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name             = azurerm_resource_group.this[var.primary_region_key].name
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true
}

resource "azurerm_storage_container" "this" {
  count                 = var.enable_storage ? 1 : 0
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.this[0].id
  container_access_type = "blob"
}
