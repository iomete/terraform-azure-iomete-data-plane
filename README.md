# IOMETE Data-Plane module

Terraform module to create infrastructure on Azure for IOMETE Data-Plane.

The module is open-source and available on GitHub: https://github.com/iomete/terraform-azure-iomete-data-plane

## Data plane installation

### Pre-requisites

Make sure you have the following tools installed on your machine:

- [Terraform CLI](https://www.terraform.io/downloads.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

### Configure Terraform file

Create a new folder and create a file (e.g. `main.tf`) with the following content:

> **_Important:_**  Update the `region`, `cluster_name` and `lakehouse_storage_account_name` values according to your
> configuration.

```hcl
module "iomete-data-plane" {
  source  = "iomete/iomete-data-plane/azure"
  version = "~> 1.2.0"

  # AKS region where cluster will be created
  region = "eastus"

  # A unique cluster name for IOMETE. It should be unique withing compatible with Azure naming conventions.
  cluster_name = "test-deployment1"

  # This is the name of the storage account. Terraform will create a storage account in Azure to store lakehouse data in ADLS Gen2.
  lakehouse_storage_account_name = "lakehouse1"
}

#################
# Outputs
#################

output "aks_connection_command" {
  value = module.iomete-data-plane.aks_connection_command
}
```

Required variables:

| Name                               | Description                                                                                                                     | Example          |
|------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|------------------|
| **region**                         | The location of the AKS cluster.                                                                                                | eastus           |
| **cluster_name**                   | A unique cluster name for IOMETE. It should be unique withing compatible with Azure naming conventions.                         | test-deployment1 |
| **lakehouse_storage_account_name** | This is the name of the storage account. Terraform will create a storage account in Azure to store lakehouse data in ADLS Gen2. | lakehouse1       |

For all available variables, see
the [variables.tf](variables.tf) file.

### Run terraform

Once you have the terraform file, and configured it according to your needs, you can run the following commands to
create the data-plane infrastructure:

```shell
# Initialize Terraform
terraform init -upgrade

# Create a plan to see what resources will be created
terraform plan

# Apply the changes to your AWS account
terraform apply
```



### Getting 403 or 409 error while creating the Gen2 storage account

**The current principal should have "Storage Blob Data Owner" role on the subscription in order to create the Gen2 storage account**

https://stackoverflow.com/questions/75110124/creating-data-lake-causes-error-code-403-or-409-checking-for-existence-of-exist

```hcl
# The current principal should have "Storage Blob Data Owner" role on the subscription in order to create the Gen2 storage account
resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "storage blob data owner"
  principal_id         = data.azurerm_client_config.current.object_id
}
```

or you can use Azure Portal to assign the role to the principal.


### Terraform state
Please, make sure terraform state files are stored on a secure location. State can be stored in a git, S3 bucket, or any
other secure location.
See here [Managing Terraform State – Best Practices & Examples](https://spacelift.io/blog/terraform-state) for more
details.