# Create a Virtual Private Cloud
resource "aws_vpc" "vpc" {
  cidr_block = infoblox_ipv4_network_container.IPv4_nw_c.cidr
  tags = {
    Name = "tf-vpc"
  }
}

# Create subnets dynamically
# Create AWS Subnets
resource "aws_subnet" "subnet" {
  for_each = toset(local.subnets)  # Use the same local variable for AWS subnets

  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = each.key  # Use the CIDR from local.subnets
  availability_zone         = element(var.availability_zones, index(local.subnets, each.key))
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch   = false

  tags = {
    Name   = "tf-subnet-${each.key}"
    Subnet = "tf-subnet-${each.key}"
  }
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}