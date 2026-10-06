terraform {
  cloud {
    organization = "stack-duel"
    workspaces {
      name = "Prod"
    }
  }

  required_version = ">= 1.14.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.61.0"
    }
  }
}
