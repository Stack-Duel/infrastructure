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
  default = [
    {
      key            = "centralus"
      location       = "centralus"
      resource_group = "rg-sd-scrum-centralus-01"
    },
    {
      key            = "eastus2"
      location       = "eastus2"
      resource_group = "rg-sd-scrum-eastus2-01"
    }
  ]
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

variable "sql_admin_password" {
  type      = string
  sensitive = true
}
