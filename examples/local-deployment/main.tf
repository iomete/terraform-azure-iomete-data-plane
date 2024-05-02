module "iomete-data-plane" {
  source                    = "../.." # for local testing

  # AKS region where cluster will be created
  region = "eastus"

  # A unique cluster name for IOMETE. It should be unique withing compatible with Azure naming conventions.
  cluster_name              = "test-deployment1"

  # This is the name of the storage account. Terraform will create a storage account in Azure to store lakehouse data in ADLS Gen2.
  lakehouse_storage_account_name     = "lakehouse1"
}

#################
# Outputs
#################

output "aks_connection_command" {
  value       = module.iomete-data-plane.aks_connection_command
}