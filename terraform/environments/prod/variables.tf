variable "region_configurations" {
  type = list(object({
    key            = string
    location       = string
    resource_group = string
  }))
}

variable "primary_region_key" {
  type    = string
  default = "centralus"
}

variable "client_region_key" {
  type    = string
  default = "eastus2"
}

variable "subscription_id" {
  type      = string
  sensitive = true
}

variable "contact_emails" {
  type      = list(string)
  sensitive = true
}

variable "budget_amount" {
  type    = number
  default = 5
}

variable "budget_start_date" {
  type = string
}

variable "budget_end_date" {
  type = string
}

variable "postgres_admin_username" {
  type      = string
  sensitive = true
}

variable "postgres_admin_password" {
  type      = string
  sensitive = true
}

variable "compute_name_suffix" {
  type    = string
  default = "02"
}

variable "migration_client_ip" {
  type    = string
  default = null
}

variable "developer_client_ip" {
  type      = string
  sensitive = true
  default   = null
}

variable "postgres_zone" {
  type = string
}
