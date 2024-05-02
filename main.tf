
data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = var.cluster_name
  location = var.region
  tags     = local.tags
}

locals {
  lakehouse_user_assigned_identity_name = "${var.cluster_name}-uai"
  module_version       = "1.2.0"

  tags = {
    "iomete.com.cluster_name" : var.cluster_name
    "iomete.com.terraform" : true
    "iomete.com.managed" : true
  }
}