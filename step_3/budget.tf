resource "azurerm_consumption_budget_subscription" "budget" {
    name            = "auto-budget"
    subscription_id = "/subscriptions/${var.subscription_id}"
    amount     = var.budget_amount
    time_grain = "Monthly"
    time_period {
        start_date = "2024-07-01T00:00:00Z"
        end_date   = "2034-01-01T00:00:00Z"
    }
 
    notification {
        enabled   = true
        threshold = 90.0
        operator  = "GreaterThan"

        contact_emails = [
            var.owner_email
        ]

        contact_groups = [
        azurerm_monitor_action_group.agroup.id,
        ]

        contact_roles = [
        "Owner"
        ]
    }
}
