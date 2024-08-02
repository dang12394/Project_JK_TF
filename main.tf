# resource "docker_container" "webapp" {
#   name  = "bezkoder-ui"
#   image = docker_image.webapp.image_id
#   ports {
#     internal = "80"
#     external = "8888"
#   }
#   networks_advanced {
#     name = docker_network.frontend.name
#   }
#   depends_on = [docker_container.api]
# }

# resource "docker_container" "api" {
#   name    = "bezkoder-api"
#   image   = docker_image.api.image_id
#   restart = "unless-stopped"
#   env = [
#     "DB_HOST=mysqldb",
#     "DB_USER=root",
#     "DB_PASSWORD=123456",
#     "DB_NAME=bezkoder_db",
#     "DB_PORT=3306",
#     "CLIENT_ORIGIN=http://127.0.0.1:8888"
#   ]
#   ports {
#     internal = "8080"
#     external = "6868"
#   }
#   networks_advanced {
#     name = docker_network.frontend.name
#   }
#   networks_advanced {
#     name = docker_network.backend.name
#   }
#   depends_on = [docker_container.mysqldb]
# }

resource "docker_container" "api" {
  name  = "php"
  image = docker_image.api.image_id
  volumes {
    host_path = "${path.cwd}/php-apache-mysql/public"
    container_path = "/var/www/html/"
  }
  networks_advanced {
     name = docker_network.frontend.name
  }
  networks_advanced {
     name = docker_network.backend.name
  }
}

resource "docker_container" "webapp" {
  name    = "apache"
  image   = docker_image.webapp.image_id
  ports {
    internal = "80"
    external = "8081"
  }
  volumes {
    host_path = "${path.cwd}/php-apache-mysql/public"
    container_path = "/var/www/html/"
  }
  networks_advanced {
     name = docker_network.frontend.name
  }
  depends_on = [docker_container.mysqldb,docker_container.api]
}

# resource "docker_container" "mysqldb" {
#   name    = "mysqldb"
#   image   = "mysql:5.7"
#   restart = "unless-stopped"
#   env = [
#     "MYSQL_ROOT_PASSWORD=123456",
#     "MYSQL_DATABASE=bezkoder_db"
#   ]
#   ports {
#     internal = "3306"
#     external = "3307"
#   }
#   volumes {
#     volume_name    = docker_volume.db.name
#     container_path = "/var/lib/mysql"
#   }

#   networks_advanced {
#     name = docker_network.backend.name
#   }
# }
resource "docker_container" "mysqldb" {
  name    = "mysql"
  image   = "mysql:5.7"
  restart = "always"
  env = [
    "MYSQL_ROOT_PASSWORD=passwd",
    "MYSQL_DATABASE=mydb",
    "MYSQL_USER=user1",
    "MYSQL_PASSWORD=passwd"
  ]
  ports {
    internal = "3306"
    external = "3306"
  }
  volumes {
    volume_name    = docker_volume.db.name
    container_path = "/var/lib/mysql"
  }

  volumes {
    host_path = "${path.cwd}/php-apache-mysql/public/dump"
    container_path = "/docker-entrypoint-initdb.d/"
  }
  networks_advanced {
     name = docker_network.backend.name
  }
}

resource "docker_network" "frontend" {
  name       = "frontend"
  attachable = true
  driver     = "bridge"
}

resource "docker_network" "backend" {
  name       = "backend"
  attachable = true
  driver     = "bridge"
}

resource "docker_volume" "db" {
  name = "db_data"
}

