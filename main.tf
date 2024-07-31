resource "docker_registry_image" "webapp" {
  name          = docker_image.webapp.name
  keep_remotely = false
}

resource "docker_image" "webapp" {
  name         = "dang12394/webapp:1.0"
  keep_locally = false
  build {
    context    = "${path.cwd}/react-nodejs-mysql/bezkoder-ui"
    dockerfile = "Dockerfile"
  }
}

resource "azurerm_resource_group" "name" {
  name     = "Project_RG"
  location = "southeastasia"
}
