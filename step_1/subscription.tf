data "azurerm_billing_enrollment_account_scope" "this" {
  billing_account_name        = var.billing_account_name
  enrollment_account_name     = var.enrollment_account_name
}

data "azurerm_management_group" "this" {
  name                        = var.subscription_management_group_id
}

data "azurerm_subscription" "this" {
  subscription_id             = azurerm_subscription.this.subscription_id
}

resource "azurerm_subscription" "this" {
  subscription_name           = "AZR_${random_string.substring.result}_${var.subscription_workload}"
  billing_scope_id            = data.azurerm_billing_enrollment_account_scope.this.id
  workload                    = "Production"
  tags                        = { 
    owner_email               = "${var.owner_email}"
    workload_type             = "${var.subscription_workload}"
    costcenter                = "${var.costcenter}"
    }
}

resource "azurerm_management_group_subscription_association" "this" {
  management_group_id         = data.azurerm_management_group.this.id
  subscription_id             = data.azurerm_subscription.this.id
}

resource "random_string" "substring" {
  length                      = 5
  upper                       = true
  min_upper                   = 3
  min_numeric                 = 2
  special                     = false
}