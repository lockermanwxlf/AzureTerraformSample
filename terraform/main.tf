terraform {
  cloud {
    organization = "lockermanwxlf"
    workspaces {
      name = "AzureTerraformSample"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "AzureTerraformSample"
  location = "westus"
}

module "container_app" {
  source                  = "./modules/containers"
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
}