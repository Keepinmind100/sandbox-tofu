output "nginx_container" {
  value = docker_container.nginx.name
}

output "postgres_container" {
  value = docker_container.postgres.name
}

output "env_file_path" {
  value = local_file.env_file.filename
}