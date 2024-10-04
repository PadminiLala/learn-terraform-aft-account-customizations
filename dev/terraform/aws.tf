# # Region being used to create the resources
# provider "aws" {
#   region  = "us-east-1"
#   assume_role {
#     role_arn     = "arn:aws:iam::311141548586:role/AWSControlTowerExecution"
#   }
# }

# # Create a VPC
# resource "aws_vpc" "vpc" {
#   cidr_block = infoblox_ipv4_network_container.IPv4_nw_c.cidr
#   tags = {
#     Name = "tf-vpc"
#   }
# }




# Region being used to create the resources


# Create a Virtual Private Cloud
# Create a Virtual Private Cloud
module "vpc" {
  source        = "../../modules/"
  network_view     = "default"
  container_cidr   = "10.117.1.0/24"
  container_comment = "tf IPv4 network container - this is VPC CIDR"
  ext_attrs        = var.ext_attrs
}


variable "ext_attrs" {
  description = "Extended attributes for the network container"
  type        = map(string)
  default     = {
    "Tenant ID" = "tf-plugin"
    "Location"  = "Test loc."
    "Site"      = "Test site"
  }
}