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

variable "clerk_api_key" {
  type      = string
  sensitive = true
}

variable "clerk_allowlist_identifiers" {
  type        = list(string)
  description = "Email addresses (or *@domain wildcards) allowed to sign up. Leave empty to leave scrum sign-ups open."
  default     = []
}
