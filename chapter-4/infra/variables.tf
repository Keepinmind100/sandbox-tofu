variable "env" {
  type = string
}

variable "nginx_port" {
  type    = number
  default = 8080
}

variable "postgres_port" {
  type    = number
  default = 5432
}

variable "postgres_user" {
  type = string
}

variable "postgres_password" {
  type      = string
  sensitive = true
}

variable "postgres_db" {
  type = string
}