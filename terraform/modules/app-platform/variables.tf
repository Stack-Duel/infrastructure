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
  description = "Key (from region_configurations) of the region that hosts the API, App Insights, and Service Bus."
}

variable "client_region_key" {
  type        = string
  description = "Key (from region_configurations) of the region that hosts the static web app client."
}

variable "compute_type" {
  type    = string
  default = "app_service"
  validation {
    condition     = contains(["app_service", "container_app"], var.compute_type)
    error_message = "compute_type must be \"app_service\" or \"container_app\"."
  }
}

variable "os_type" {
  type    = string
  default = "Windows"
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be \"Windows\" or \"Linux\"."
  }
}

variable "sku_name" {
  type    = string
  default = "F1"
}

variable "always_on" {
  type    = bool
  default = false
}

variable "dotnet_version" {
  type    = string
  default = "v10.0"
}


variable "compute_name_suffix" {
  type    = string
  default = "01"
}

variable "resource_name_suffix" {
  type    = string
  default = "01"
}

variable "service_bus_name_suffix" {
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

variable "enable_service_bus" {
  type    = bool
  default = true
}

variable "service_bus_sku" {
  type    = string
  default = "Basic"
}

variable "service_bus_queue_names" {
  type    = list(string)
  default = ["submission-created", "submission-job-continuation", "game-time-expired"]
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

variable "enable_avatar_storage" {
  type    = bool
  default = true
}

variable "storage_account_name_suffix" {
  type    = string
  default = "01"
}

variable "avatar_container_name" {
  type    = string
  default = "avatars"
}
