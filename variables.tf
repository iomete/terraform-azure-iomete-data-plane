variable "cluster_name" {
  type        = string
  description = "A unique cluster name for IOMETE. It should be unique withing compatible with Azure naming conventions."
}

variable "lakehouse_storage_account_name" {
  type        = string
  description = "Storage account name for the cluster"
}

variable "region" {
  type        = string
  description = "AKS region where cluster will be created"
}

variable "aks_version" {
  description = "AKS kubernetes version"
  type        = string
  default     = "1.29.0"
}

variable "exec_max_count" {
  type        = number
  default     = 1000
  description = "Max. Node count for for lakehouse executor"
}

variable "exec_min_count" {
  type        = number
  default     = 0
  description = "Min. Node count for for lakehouse executor"

}

variable "driver_max_count" {
  type        = number
  default     = 100
  description = "Maximum Node count for for driver"
}

variable "driver_min_count" {
  type        = number
  default     = 0
  description = "Maximum Node count for for driver"

}

variable "system_vm_size" {
  type        = string
  default     = "Standard_D4as_v5"
  description = "Node size for for system"

}

variable "address_space" {
  type        = list(any)
  default     = ["10.8.0.0/16"]
  description = "Address space for the cluster network"
}

variable "cluster_subnet" {
  type        = list(any)
  default     = ["10.8.0.0/21"]
  description = "Subnet prefixes for the cluster network"
}

variable "service_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Service cidr for the cluster"
}

variable "dns_service_ip" {
  type        = string
  default     = "10.0.0.10"
  description = "DNS service ip for the cluster"
}