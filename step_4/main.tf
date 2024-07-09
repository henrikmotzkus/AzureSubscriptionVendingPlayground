module "lz_vending" {
  source  = "Azure/lz-vending/azurerm"
  version = "4.1.2" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  # Set the default location for resources
  location = "swedencentral"
     

  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_name}/enrollmentAccounts/${var.enrollment_account_name}"
  subscription_display_name  = "AZR_SPOKE1_Dev"
  subscription_alias_name    = "AZR_SPOKE1_Dev"
  subscription_workload      = "Production"

  network_watcher_resource_group_enabled = true

  # management group association variables
  subscription_management_group_association_enabled = true
  subscription_management_group_id                  = var.subscription_management_group_id

  # virtual network variables
  virtual_network_enabled = true
  virtual_networks = {
    one = {
      name                    = "vnet-spoke-1-a"
      address_space           = ["192.168.1.0/24"]
      hub_peering_enabled     = true
      hub_network_resource_id = "/subscriptions/a70316fd-0761-4d1d-aa6a-743ef1133f7a/resourceGroups/Hub_VNET/providers/Microsoft.Network/virtualNetworks/VNET-hub-1"
      mesh_peering_enabled    = true
      resource_group_name     = "Rg_Network_1-a"
    }
    two = {
      name                    = "vnet-spoke-1-b"
      location                = "northeurope"
      address_space           = ["192.168.2.0/24"]
      hub_peering_enabled     = true
      hub_network_resource_id = "/subscriptions/a70316fd-0761-4d1d-aa6a-743ef1133f7a/resourceGroups/Hub_VNET/providers/Microsoft.Network/virtualNetworks/VNET-hub-1"
      mesh_peering_enabled    = true
      resource_group_name     = "Rg_Network_1-b"
    }
  }

  umi_enabled             = true
  umi_name                = "umi"
  umi_resource_group_name = "Rg-identity"
  umi_role_assignments = {
    myrg-contrib = {
      definition     = "Contributor"
      relative_scope = "/resourceGroups/Rg-Managed"
    }
  }

  resource_group_creation_enabled = true
  resource_groups = {
    myrg = {
      name     = "Rg-Managed"
      location = "swedencentral"
    }
  }

  # role assignments
  role_assignment_enabled = true
  role_assignments = {
    # using role definition name, created at subscription scope
    contrib_user_sub = {
      principal_id   = "a596c8bc-ab77-44c7-ac10-e22e2d958d05"
      definition     = "Contributor"
      relative_scope = ""
    },
    # using relative scope (to the created or supplied subscription)
    rg_owner = {
      principal_id   = "a596c8bc-ab77-44c7-ac10-e22e2d958d05"
      definition     = "Owner"
      relative_scope = "/resourceGroups/Rg-Managed"
    },
  }
}