variable "contact_emails" {
  type      = list(string)
  sensitive = true
}

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

variable "resource_group" {
  type = string
}

variable "subscription_id" {
  type      = string
  sensitive = true
}

variable "aiven_project_name" {
  type      = string
  sensitive = true
}

variable "aiven_cloud_name" {
  type = string
}

variable "aiven_pg_plan" {
  type = string
}

variable "aiven_api_token" {
  type      = string
  sensitive = true
}
