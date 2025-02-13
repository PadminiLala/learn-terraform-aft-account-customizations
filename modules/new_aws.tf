# Create a Virtual Private Cloud
resource "aws_vpc" "vpc" {
  cidr_block = "10.117.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
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

locals {
  subnet_count = 3  # Number of subnets to create
  prefix_length = 26 # Prefix length for subnets

  # Calculate subnet CIDRs based on parent CIDR
  subnets = [
    for i in range(local.subnet_count) :
    cidrsubnet(var.container_cidr, local.prefix_length - 24, i)
  ]
}


# resource "aws_vpc_dhcp_options" "example" {
#   domain_name_servers = ["10.0.0.2", "AmazonProvidedDNS"]  # Custom DNS server
#   domain_name         = "aftterraform.com"                      # Custom domain
# }

# resource "aws_vpc_dhcp_options_association" "example" {
#   vpc_id          = aws_vpc.vpc.id
#   dhcp_options_id = aws_vpc_dhcp_options.example.id
# }
# # Create an Internet Gateway (for public internet access)
# resource "aws_internet_gateway" "example" {
#   vpc_id = aws_vpc.vpc.id
# }
# # Creating a Route Table
# resource "aws_route_table" "example" {
#   vpc_id = aws_vpc.vpc.id

#   # Define routes (example: route to the internet gateway)
#   route {
#     cidr_block = "0.0.0.0/0"         # This allows internet traffic
#     gateway_id = aws_internet_gateway.example.id
#   }

# }













variable "container_cidr" {
  description = "The CIDR for the IPv4 network container"
  type        = string
  default     = "10.117.0.0/24"
}


variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}
