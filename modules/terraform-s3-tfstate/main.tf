terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }
  backend "s3" {
    bucket         = "marublaize-s3-tfstate"
    key            = "devops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-locks"
    encrypt        = true
    }
}

provider "aws" {
  region     = "us-east-1"
}
