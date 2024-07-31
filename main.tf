resource "docker_registry_image" "webapp" {
  name          = docker_image.webapp.name
  keep_remotely = true
}

resource "docker_image" "webapp" {
  name = "dang12394/webapp:latest"
  build {
    context    = "${path.cwd}/src/Web/"
    dockerfile = "Dockerfile"
  }
}