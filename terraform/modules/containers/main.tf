terraform {
  cloud {
    organization = "lockermanwxlf"
    workspaces {
      name = "AzureTerraformSample"
    }
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_container_app_environment" "env" {
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name                = "TerraformSampleCAE"
}

resource "azurerm_container_app" "name" {
  name                         = "web-api-app"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"
  template {
    min_replicas = 0
    max_replicas = 2
    container {
      image  = "docker.io/lockermanwxlf/azure_terraform_sample:main"
      cpu    = 0.25
      memory = "0.5Gi"
      name   = "web-api"
    }
  }
  ingress {
    target_port = 8080
    external_enabled = true
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}