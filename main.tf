resource "docker_registry_image" "webapp" {
  provider = docker
  name          = docker_image.webapp.name
  keep_remotely = false
}

resource "docker_image" "webapp" {
  provider = docker
  name         = "${azurerm_container_registry.my_acr.login_server}/webapp:1.0"
  keep_locally = false
  build {
    context    = "${path.cwd}/react-nodejs-mysql/bezkoder-ui"
    dockerfile = "Dockerfile"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "Project_RG"
  location = var.region
}
