provider "azurerm" {
  features {}
}

provider "azapi" {}

provider "clerk" {
  api_key = var.clerk_api_key
}
