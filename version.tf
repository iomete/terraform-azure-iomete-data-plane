terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.39"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 2.1.0"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}