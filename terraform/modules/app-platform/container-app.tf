resource "azurerm_container_app_environment" "api" {
  count                      = var.compute_type == "container_app" ? 1 : 0
  name                       = "cae-sdapi-${var.environment_key}-${var.primary_region_key}-${var.resource_name_suffix}"
  location                   = azurerm_resource_group.this[var.primary_region_key].location
  resource_group_name        = azurerm_resource_group.this[var.primary_region_key].name
  log_analytics_workspace_id = var.enable_app_insights ? azurerm_log_analytics_workspace.api[0].id : null
}

resource "azurerm_container_app" "api" {
  count                        = var.compute_type == "container_app" ? 1 : 0
  name                         = "ca-sdapi-${var.environment_key}-${var.primary_region_key}-${var.compute_name_suffix}"
  container_app_environment_id = azurerm_container_app_environment.api[0].id
  resource_group_name          = azurerm_resource_group.this[var.primary_region_key].name
  revision_mode                = "Single"

  template {
    min_replicas = var.container_min_replicas
    max_replicas = var.container_max_replicas

    container {
      name   = "api"
      image  = var.container_image
      cpu    = var.container_cpu
      memory = var.container_memory
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.container_target_port
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  dynamic "secret" {
    for_each = var.container_registry_server != null ? [1] : []
    content {
      name  = "registry-password"
      value = var.container_registry_password
    }
  }

  dynamic "registry" {
    for_each = var.container_registry_server != null ? [1] : []
    content {
      server               = var.container_registry_server
      username             = var.container_registry_username
      password_secret_name = "registry-password"
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].image,
      tags
    ]
  }
}
