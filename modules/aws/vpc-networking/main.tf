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
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Internet routing through NAT Gateway
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  database_subnets     = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
  intra_subnets        = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"] # no Internet routing

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}
