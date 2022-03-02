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

# variable "vpc_id" {
#   default = "vpc-012b6e67de861606e"
# }

# variable "vpc_cidr" {
#   type    = list(string)
#   default = [
#     "10.0.0.0/16"
#   ]
# }

# variable "private_subnets" {
#   type    = list(string)
#   default = [
#     "subnet-0d4adfd9e43bb1382",
#     "subnet-015610a0eb10efe6a",
#     "subnet-0aaf1f197860d73eb"
#   ]
# }

# variable "public_subnets" {
#   type    = list(string)
#   default = [
#     "subnet-0adfcfe7fa8f226a2",
#     "subnet-08c7520ad1fbd671c",
#     "subnet-03e2c0756077cb65a"
#   ]
# }
