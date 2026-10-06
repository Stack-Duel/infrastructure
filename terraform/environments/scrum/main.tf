module "scrum" {
  source = "../../modules/app-platform"

  environment_key       = "scrum"
  region_configurations = var.region_configurations
  primary_region_key    = var.primary_region_key
  client_region_key     = var.client_region_key

  os_type                 = "Linux"
  sku_name                = "F1"
  always_on               = false
  compute_name_suffix     = "03"
  resource_name_suffix    = "01"
  service_bus_name_suffix = "01"

  enable_app_insights = true
  enable_service_bus  = true
  service_bus_sku     = "Standard"

  enable_avatar_storage = true

  enable_budget     = true
  enable_alerts     = true
  subscription_id   = var.subscription_id
  budget_name       = "monthly-budget"
  budget_amount     = 5
  budget_start_date = "2026-02-01T00:00:00Z"
  budget_end_date   = "2026-12-31T23:59:59Z"
  budget_thresholds = [3, 5]
  contact_emails    = var.contact_emails
}

resource "aiven_pg" "sql" {
  project      = var.aiven_project_name
  cloud_name   = var.aiven_cloud_name
  plan         = var.aiven_pg_plan
  service_name = "pg-3c675c6d"
}
