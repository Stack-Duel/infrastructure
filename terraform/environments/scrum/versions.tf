terraform {
  cloud {
    organization = "stack-duel"
    workspaces {
      name = "Scrum"
    }
  }

  required_version = ">= 1.14.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.14.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }
}
