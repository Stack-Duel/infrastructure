module "scrum" {
  source = "../../modules/app-platform"

  environment_key       = "scrum"
  region_configurations = var.region_configurations
  primary_region_key    = var.primary_region_key
  client_region_key     = var.client_region_key

  resource_name_suffix = "01"

  enable_app_insights = true

  enable_storage         = true
  storage_container_name = "uploads"

  enable_sql         = true
  sql_admin_login    = "sqladmin"
  sql_admin_password = var.sql_admin_password

  container_min_replicas = 0
  container_max_replicas = 1

  enable_clerk                   = true
  clerk_allowlist_identifiers    = var.clerk_allowlist_identifiers
  clerk_additional_redirect_urls = ["http://localhost:3000/sso-callback"]

  enable_budget     = true
  enable_alerts     = true
  subscription_id   = var.subscription_id
  budget_name       = "monthly-budget"
  budget_amount     = 5
  budget_start_date = "2026-10-01T00:00:00Z"
  budget_end_date   = "2026-12-31T23:59:59Z"
  budget_thresholds = [3, 5]
  contact_emails    = var.contact_emails
}
