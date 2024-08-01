terraform {

  cloud {
    organization = "dang12394"
    workspaces {
      name = "Project_DevOps"
    }
    token = "mjHfpoDE59JSMg.atlasv1.8oykzsJANahKKxaeSpjMyY2B8LUlUvJyzOKpMndGuDN125gB1y0qhzPL4WPFi4mZZUI"
  }
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.113.0"
    }
  }
  required_version = "~>1.9.3"
}

provider "docker" {
  #host = "npipe:////.//pipe//docker_engine"
  registry_auth {
    address  = azurerm_container_registry.my_acr.login_server
    username = azurerm_container_registry.my_acr.admin_username
    password = azurerm_container_registry.my_acr.admin_password
  }

}

provider "azurerm" {
  features {}
}

