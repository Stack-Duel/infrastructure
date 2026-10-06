resource "azurerm_service_plan" "api" {
  count               = var.compute_type == "app_service" ? 1 : 0
  name                = "asp-sdapi-${var.environment_key}-${var.primary_region_key}-${var.compute_name_suffix}"
  location            = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_windows_web_app" "api" {
  count               = var.compute_type == "app_service" && var.os_type == "Windows" ? 1 : 0
  name                = "app-sdapi-${var.environment_key}-${var.primary_region_key}-${var.compute_name_suffix}"
  location            = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  service_plan_id     = azurerm_service_plan.api[0].id
  https_only          = true

  site_config {
    always_on          = var.always_on
    websockets_enabled = true
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = var.dotnet_version
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      tags,
      logs,
      sticky_settings
    ]
  }
}

resource "azurerm_linux_web_app" "api" {
  count               = var.compute_type == "app_service" && var.os_type == "Linux" ? 1 : 0
  name                = "app-sdapi-${var.environment_key}-${var.primary_region_key}-${var.compute_name_suffix}"
  location            = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name = azurerm_resource_group.this[var.primary_region_key].name
  service_plan_id     = azurerm_service_plan.api[0].id
  https_only          = true

  site_config {
    always_on          = var.always_on
    websockets_enabled = true
    application_stack {
      dotnet_version = trimprefix(var.dotnet_version, "v")
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      tags,
      logs,
      sticky_settings
    ]
  }
}
