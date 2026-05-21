terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# -------------------------
# Docker Network
# -------------------------
resource "docker_network" "devops_network" {
  name = "terraform-devops-network"
}

# -------------------------
# PostgreSQL Container
# -------------------------
resource "docker_image" "postgres_image" {
  name = "postgres:15-alpine"
}

resource "docker_container" "postgres_container" {
  name  = "terraform-postgres"
  image = docker_image.postgres_image.image_id

  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=admin123",
    "POSTGRES_DB=devopsdb"
  ]

  networks_advanced {
    name = docker_network.devops_network.name
  }
}

# -------------------------
# Flask App Image
# -------------------------
resource "docker_image" "flask_image" {
  name = "terraform-flask-app"

  build {
    context    = abspath("${path.cwd}/../")
    dockerfile = "Dockerfile"
  }
}


# -------------------------
# Flask Container
# -------------------------
resource "docker_container" "flask_container" {
  name  = "terraform-flask-container"
  image = docker_image.flask_image.image_id

  ports {
    internal = 5000
    external = 5050
  }

  env = [
    "DB_HOST=terraform-postgres",
    "DB_NAME=devopsdb",
    "DB_USER=admin",
    "DB_PASSWORD=admin123"
  ]

  networks_advanced {
    name = docker_network.devops_network.name
  }

  depends_on = [
    docker_container.postgres_container
  ]
}