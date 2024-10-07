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
provider "infoblox" {
  server = "34.199.124.91"
  username = "admin"
  password = data.aws_ssm_parameters_by_path.infoblox_parms.values
  sslmode = false
}
data "aws_ssm_parameters_by_path" "infoblox_parms" {
  path            = "/aft/infoblox"
  with_decryption = true
  recursive       = true
}

output "sensitive_example_hash" {
  value = nonsensitive(data.aws_ssm_parameters_by_path.infoblox_parms.values)
}