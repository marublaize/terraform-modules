variable "cluster_name" {
  default = "ecs-cluster"
}

variable "container_name" {
  default = "nginx"
}

variable "container_image" {
  default = "nginx"
}

variable "container_port" {
  type    = number
  default = 80
}
