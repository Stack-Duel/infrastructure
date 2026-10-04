resource "azurerm_consumption_budget_subscription" "this" {
  count           = var.enable_budget ? 1 : 0
  name            = var.budget_name
  amount          = var.budget_amount
  subscription_id = "/subscriptions/${var.subscription_id}"
  time_grain      = "Monthly"

  time_period {
    start_date = var.budget_start_date
    end_date   = var.budget_end_date
  }

  dynamic "notification" {
    for_each = var.budget_thresholds
    content {
      operator       = "GreaterThan"
      threshold      = notification.value
      enabled        = true
      contact_emails = var.contact_emails
      contact_roles  = []
      contact_groups = []
    }
  }
}
