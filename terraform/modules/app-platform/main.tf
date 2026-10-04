resource "azurerm_resource_group" "this" {
  for_each = { for rc in var.region_configurations : rc.key => rc }
  name     = each.value.resource_group
  location = each.value.location
}
