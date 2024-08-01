resource "azurerm_container_registry" "my_acr" {
  name                = "dang12394"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  location            = var.region
  admin_enabled       = true
}

resource "docker_registry_image" "webapp" {
  provider      = docker
  name          = docker_image.webapp.name
  keep_remotely = false
}

resource "docker_registry_image" "api" {
  provider      = docker
  name          = docker_image.api.name
  keep_remotely = false
}

resource "docker_image" "webapp" {
  provider     = docker
  name         = "${azurerm_container_registry.my_acr.login_server}/webapp:1.0"
  keep_locally = false
  build {
    context    = "${path.cwd}/react-nodejs-mysql/bezkoder-ui"
    dockerfile = "Dockerfile"
    build_args = {
      REACT_APP_API_BASE_URL = "http://127.0.0.1:6868/api"
    }
  }
}

resource "docker_image" "api" {
  provider     = docker
  name         = "${azurerm_container_registry.my_acr.login_server}/api:1.0"
  keep_locally = false
  build {
    context    = "${path.cwd}/react-nodejs-mysql/bezkoder-api"
    dockerfile = "Dockerfile"
  }
}


resource "azurerm_resource_group" "rg" {
  name     = "Project_RG"
  location = var.region
}
