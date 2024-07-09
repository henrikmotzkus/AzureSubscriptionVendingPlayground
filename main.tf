module "subscription" {
    source = "./step_1"
    owner_email = var.owner_email
    costcenter = var.cost_center
    subscription_workload = var.subscription_workload
    subscription_management_group_id = var.subscription_management_group_id
    billing_account_name = "8608480"
    enrollment_account_name = "341847"
}

module "budget" {
    providers = {azurerm = azurerm.sub}
    source = "./step_3"
    owner_email = var.owner_email
    budget_amount = var.budget_amount
    subscription_id = module.subscription.subscription_id
}