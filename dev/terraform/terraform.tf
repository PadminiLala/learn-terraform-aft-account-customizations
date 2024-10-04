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

data "aws_ssm_parameters_by_path" "infoblox_parms" {
  with_decryption = true
  path  = "/infoblox"
}
locals {
  infoblox_params = { for param in data.aws_ssm_parameters_by_path.infoblox_params.parameters : param.name => param.value }
}


provider "infoblox" {
  server = "34.199.124.91"
  username = "admin"
  password = data.aws_ssm_parameter.infoblox_password.value
  sslmode = false
}