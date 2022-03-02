resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  vpc_name = "vpc-${random_string.suffix.result}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = "${local.vpc_name}"
  cidr                 = "172.16.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  public_subnets       = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "ecs/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "ecs/cluster/${var.cluster_name}" = "shared"
    "ecs/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "ecs/cluster/${var.cluster_name}" = "shared"
    "ecs/role/internal-elb"             = "1"
  }
}
