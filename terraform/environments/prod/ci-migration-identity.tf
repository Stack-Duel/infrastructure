data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "github_migrator" {
  name                = "id-gh-migrator-prod-centralus-01"
  resource_group_name = module.prod.resource_group_names["centralus"]
  location            = module.prod.resource_group_locations["centralus"]
}

resource "azurerm_federated_identity_credential" "github_migrator_production" {
  name      = "gh-server-production"
  parent_id = azurerm_user_assigned_identity.github_migrator.id
  audience  = ["api://AzureADTokenExchange"]
  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:Stack-Duel/server:environment:production"
}

resource "azurerm_role_definition" "postgres_firewall_manager" {
  name        = "Postgres Flexible Server Firewall Manager"
  scope       = azurerm_postgresql_flexible_server.prod.id
  description = "Allows adding and removing firewall rules on the prod Postgres flexible server only. Used by CI to open a rule for the duration of a migration/seed job."

  permissions {
    actions = [
      "Microsoft.DBforPostgreSQL/flexibleServers/firewallRules/read",
      "Microsoft.DBforPostgreSQL/flexibleServers/firewallRules/write",
      "Microsoft.DBforPostgreSQL/flexibleServers/firewallRules/delete",
    ]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_postgresql_flexible_server.prod.id,
  ]
}

resource "azurerm_role_assignment" "github_migrator_firewall" {
  scope              = azurerm_postgresql_flexible_server.prod.id
  role_definition_id = azurerm_role_definition.postgres_firewall_manager.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.github_migrator.principal_id
}
