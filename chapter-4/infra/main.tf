terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "postgres" {
  name = "postgres:15"
}

resource "docker_container" "nginx" {
  name  = "nginx-${var.env}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.nginx_port
  }

  depends_on = [docker_image.nginx]
}

resource "docker_container" "postgres" {
  name  = "postgres-${var.env}"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}"
  ]

  ports {
    internal = 5432
    external = var.postgres_port
  }

  depends_on = [docker_image.postgres]
}

resource "local_file" "env_file" {
  content  = templatefile("${path.module}/templates/.env.tpl", {
    db_name      = var.postgres_db
    db_user      = var.postgres_user
    db_password  = var.postgres_password
  })
  filename = "${path.module}/output/.env.${var.env}"
}