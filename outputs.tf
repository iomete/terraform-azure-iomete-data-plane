output "lakehouse_uai" {
  value = azurerm_user_assigned_identity.lakehouse.id
}

output "aks_connection_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${var.cluster_name} --overwrite-existing"
}