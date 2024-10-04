terraform {
  # Required providers block for Terraform v0.14.7
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
    infoblox = {
      source = "infobloxopen/infoblox"
      version = "~> 2.0"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::311141548586:role/AWSControlTowerExecution"
  }
}

provider "infoblox" {
  server = "34.199.124.91"
  username = "admin"
  password = "2p#MiT=-Sq#B7P2"
  sslmode = false
}