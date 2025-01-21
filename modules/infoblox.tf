# # Create a network container in Infoblox Grid
# terraform {
#   required_providers {
#     infoblox = {
#       source  = "infobloxopen/infoblox"
#       version = "~> 2.0"
#     }
#   }
# }
# resource "infoblox_ipv4_network_container" "IPv4_nw_c" {
#   network_view = var.network_view

#   cidr    = var.container_cidr
#   comment = var.container_comment
#   ext_attrs = jsonencode(var.ext_attrs)
# }

# locals {
#   subnet_count = 3  # Number of subnets to create
#   prefix_length = 26 # Prefix length for subnets

#   # Calculate subnet CIDRs based on parent CIDR
#   subnets = [
#     for i in range(local.subnet_count) :
#     cidrsubnet(var.container_cidr, local.prefix_length - 24, i)
#   ]
# }

# # Allocate networks dynamically using for_each
# resource "infoblox_ipv4_network" "ipv4_network" {
#   for_each = toset(local.subnets)

#   network_view        = var.network_view
#   parent_cidr         = infoblox_ipv4_network_container.IPv4_nw_c.cidr
#   allocate_prefix_len  = local.prefix_length
#   reserve_ip           = 3  # Adjust as needed

#   comment = "tf IPv4 network for ${each.key}"
#   ext_attrs = jsonencode({
#     "Tenant ID"    = "tf-plugin"
#     "Network Name" = "ipv4-tf-network-${each.key}"
#     "Location"     = "Test loc."
#     "Site"         = "Test site"
#   })

#   cidr = each.key
# }

