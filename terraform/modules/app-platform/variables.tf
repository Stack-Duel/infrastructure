variable "environment_key" {
  type        = string
  description = "Short environment identifier used in resource names, e.g. \"scrum\" or \"prod\"."
}

variable "region_configurations" {
  type = list(object({
    key            = string
    location       = string
    resource_group = string
  }))
}

variable "primary_region_key" {
  type        = string
  description = "Key (from region_configurations) of the region that hosts the API, database, storage, and App Insights."
}

variable "client_region_key" {
  type        = string
  description = "Key (from region_configurations) of the region that hosts the static web app client."
}

variable "resource_name_suffix" {
  type    = string
  default = "01"
}

variable "enable_app_insights" {
  type    = bool
  default = true
}

variable "daily_data_cap_in_gb" {
  type    = number
  default = 0.1
}

variable "log_retention_in_days" {
  type    = number
  default = 30
}

variable "static_web_app_sku_tier" {
  type    = string
  default = "Free"
}

variable "static_web_app_sku_size" {
  type    = string
  default = "Free"
}

variable "enable_budget" {
  type    = bool
  default = true
}

variable "enable_alerts" {
  type    = bool
  default = true
}

variable "subscription_id" {
  type      = string
  sensitive = true
  default   = null
}

variable "budget_name" {
  type    = string
  default = "monthly-budget"
}

variable "budget_amount" {
  type    = number
  default = 5
}

variable "budget_start_date" {
  type    = string
  default = null
}

variable "budget_end_date" {
  type    = string
  default = null
}

variable "budget_thresholds" {
  type    = list(number)
  default = [3, 5]
}

variable "contact_emails" {
  type      = list(string)
  sensitive = true
  default   = []
}

variable "container_image" {
  type    = string
  default = "mcr.microsoft.com/k8se/quickstart:latest"
}

variable "container_cpu" {
  type    = number
  default = 0.25
}

variable "container_memory" {
  type    = string
  default = "0.5Gi"
}

variable "container_min_replicas" {
  type    = number
  default = 0
}

variable "container_max_replicas" {
  type    = number
  default = 1
}

variable "container_target_port" {
  type    = number
  default = 8080
}

variable "container_registry_server" {
  type    = string
  default = null
}

variable "container_registry_username" {
  type    = string
  default = null
}

variable "container_registry_password" {
  type      = string
  sensitive = true
  default   = null
}

variable "enable_storage" {
  type    = bool
  default = true
}

variable "storage_account_name_suffix" {
  type    = string
  default = "01"
}

variable "storage_container_name" {
  type    = string
  default = "uploads"
}

variable "enable_sql" {
  type    = bool
  default = true
}

variable "sql_admin_login" {
  type    = string
  default = "sqladmin"
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "sql_database_max_size_gb" {
  type    = number
  default = 32
}

variable "sql_database_min_capacity" {
  type    = number
  default = 0.5
}

variable "sql_database_auto_pause_delay_in_minutes" {
  type    = number
  default = 60
}