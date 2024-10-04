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

# # Create subnets dynamically in different availability zones
# resource "aws_subnet" "subnet" {
#   for_each = local.subnet_az_map

#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = each.key
#   availability_zone = each.value
#   assign_ipv6_address_on_creation = false
#   map_public_ip_on_launch = false

#   tags = {
#     Name   = "tf-subnet-${each.key}"
#     Subnet = "tf-subnet-${each.key}"
#   }
# }


# Region being used to create the resources


# Create a Virtual Private Cloud
# Create a Virtual Private Cloud
module "vpc" {
  source        = "./modules/"
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