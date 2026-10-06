module "prod" {
  source = "../../modules/app-platform"

  environment_key       = "prod"
  region_configurations = var.region_configurations
  primary_region_key    = var.primary_region_key
  client_region_key     = var.client_region_key

  compute_type            = "app_service"
  os_type                 = "Linux"
  sku_name                = "B1"
  always_on               = true
  compute_name_suffix     = var.compute_name_suffix
  resource_name_suffix    = "01"
  service_bus_name_suffix = "02"

  enable_app_insights = true
  enable_service_bus  = true
  service_bus_sku     = "Basic"

  enable_avatar_storage = true

  enable_budget     = true
  enable_alerts     = true
  subscription_id   = var.subscription_id
  budget_name       = "monthly-budget"
  budget_amount     = var.budget_amount
  budget_start_date = var.budget_start_date
  budget_end_date   = var.budget_end_date
  budget_thresholds = [50, 80, 100]
  contact_emails    = var.contact_emails
}
