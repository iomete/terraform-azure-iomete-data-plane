###############################################
# AKS Cluster
###############################################

resource "azurerm_kubernetes_cluster" "main" {
  name = var.cluster_name

  ### choose the resource group to use for the cluster
  location                  = azurerm_resource_group.main.location
  resource_group_name       = azurerm_resource_group.main.name
  node_resource_group       = "${azurerm_resource_group.main.name}-noderg"
  dns_prefix                = var.cluster_name
  kubernetes_version        = var.aks_version
  workload_identity_enabled = true
  oidc_issuer_enabled       = true

  default_node_pool {
    name                        = "systempool"
    zones                       = [1]
    node_count                  = 1
    min_count                   = 1
    max_count                   = 3
    max_pods                    = 110
    vm_size                     = var.system_vm_size
    vnet_subnet_id              = azurerm_subnet.nv-sn-cluster.id
    type                        = "VirtualMachineScaleSets"
    enable_auto_scaling         = true
    enable_host_encryption      = false
    temporary_name_for_rotation = "nodeupgrade"
  }

  tags = local.tags
  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
    network_policy    = "azure"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  http_application_routing_enabled = false

  identity {
    type = "SystemAssigned"
  }
}

###############################################
# driver pool
###############################################

resource "azurerm_kubernetes_cluster_node_pool" "driver-small" {
  name                  = "dsmall" #│ Error: the "name" must begin with a lowercase letter, contain only lowercase letters and numbers and be between 1 and 12 characters in length
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_E2ps_v5"
  node_count            = 0
  enable_auto_scaling   = true
  min_count             = var.driver_min_count
  max_count             = var.driver_max_count
  priority              = "Regular"
  os_type               = "Linux"
  orchestrator_version  = var.aks_version
  vnet_subnet_id        = azurerm_subnet.nv-sn-cluster.id

  #os_disk_size_gb = 30
  tags = local.tags
  node_labels = {
    "k8s.iomete.com/node-purpose" = "driver-small"
  }

  node_taints = ["k8s.iomete.com/dedicated=driver-small:NoSchedule"]

  depends_on = [azurerm_kubernetes_cluster.main]
}

resource "azurerm_kubernetes_cluster_node_pool" "driver-medium" {
  name                  = "dmedium"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_E4ps_v5"
  node_count            = 0
  enable_auto_scaling   = true
  min_count             = var.driver_min_count
  max_count             = var.driver_max_count
  priority              = "Regular"
  os_type               = "Linux"
  orchestrator_version  = var.aks_version
  vnet_subnet_id        = azurerm_subnet.nv-sn-cluster.id

  #os_disk_size_gb = 30
  tags = local.tags
  node_labels = {
    "k8s.iomete.com/node-purpose" = "driver-medium"
  }

  node_taints = ["k8s.iomete.com/dedicated=driver-medium:NoSchedule"]

  depends_on = [azurerm_kubernetes_cluster.main]
}



##############################################
# executer pool
##############################################

resource "azurerm_kubernetes_cluster_node_pool" "exec-small" {
  name                  = "esmall"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_E2pds_v5"
  node_count            = 0
  enable_auto_scaling   = true
  min_count             = var.exec_min_count
  max_count             = var.exec_max_count
  priority              = "Regular"
  os_type               = "Linux"
  orchestrator_version  = var.aks_version
  vnet_subnet_id        = azurerm_subnet.nv-sn-cluster.id

  #os_disk_size_gb = 30
  tags = local.tags
  node_labels = {
    "k8s.iomete.com/node-purpose" = "exec-small"
  }

  node_taints = ["k8s.iomete.com/dedicated=exec-small:NoSchedule"]

  depends_on = [azurerm_kubernetes_cluster.main]
}


resource "azurerm_kubernetes_cluster_node_pool" "exec-medium" {
  name                  = "emedium"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_E8pds_v5"
  node_count            = 0
  enable_auto_scaling   = true
  min_count             = var.exec_min_count
  max_count             = var.exec_max_count
  priority              = "Regular"
  os_type               = "Linux"
  orchestrator_version  = var.aks_version
  vnet_subnet_id        = azurerm_subnet.nv-sn-cluster.id

  #os_disk_size_gb = 30
  tags = local.tags
  node_labels = {
    "k8s.iomete.com/node-purpose" = "exec-medium"
  }

  node_taints = ["k8s.iomete.com/dedicated=exec-medium:NoSchedule"]

  depends_on = [azurerm_kubernetes_cluster.main]
}


resource "azurerm_kubernetes_cluster_node_pool" "exec-large" {
  name                  = "elarge"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_E16pds_v5"
  node_count            = 0
  enable_auto_scaling   = true
  min_count             = var.exec_min_count
  max_count             = var.exec_max_count
  priority              = "Regular"
  os_type               = "Linux"
  orchestrator_version  = var.aks_version
  vnet_subnet_id        = azurerm_subnet.nv-sn-cluster.id

  tags = local.tags
  node_labels = {
    "k8s.iomete.com/node-purpose" = "exec-large"
  }

  node_taints = ["k8s.iomete.com/dedicated=exec-large:NoSchedule"]

  depends_on = [azurerm_kubernetes_cluster.main]
}