terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }
  required_version = "> 0.14"
}

provider "aws" {
  region = var.region
}
