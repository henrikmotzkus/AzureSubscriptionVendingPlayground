resource "azurerm_monitor_action_group" "agroup" {
    name                = "owner-alerts"
    resource_group_name = azurerm_resource_group.rg-managed.name
    short_name          = "owner-alerts"
    email_receiver {
        name          = "sendtowoner"
        email_address = var.owner_email
    }
}