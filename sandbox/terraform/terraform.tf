terraform {
  # Required providers block for Terraform v0.14.7
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
    infoblox = {
      source = "infobloxopen/infoblox"
      version = "~> 2.0"
    }
  }
}
provider "infoblox" {
  server = "98.82.52.99"
  username = "admin"
  password = local.password
  sslmode = false
}
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
data "aws_ssm_parameter" "infoblox_parms" {
  name = "arn:aws:ram:us-east-1:311141548586:resource-share/bec6066b-4af9-4ee0-af82-34f3d072033c"
}
locals {
  password = data.aws_ssm_parameter.infoblox_parms.value[0]
}

output "sensitive_example_hash" {
  value = nonsensitive(data.aws_ssm_parameter.infoblox_parms.value)
}
