variable "subscription_workload" {
    type = string
    validation {
      condition = contains(["Prod", "DevTest"], var.subscription_workload)
      error_message = "Valid values are Prod and DevTest"
    }
}

variable "subscription_management_group_id" {
  type        = string
  default     = ""
}

variable "billing_account_name" {
    type = string
    default = ""
}

variable "enrollment_account_name" {
    type = string
    default = ""
}

variable  "owner_email" {
    type = string
}

variable "budget_amount" {
    type = string
}

variable "cost_center" {
  type = string
}