# Define variables
variable "network_view" {
  description = "The network view to use"
  type        = string
  default     = "default"
}

variable "container_cidr" {
  description = "The CIDR for the IPv4 network container"
  type        = string
  default     = "10.117.0.0/24"
}

variable "container_comment" {
  description = "Comment for the network container"
  type        = string
  default     = "tf IPv4 network container - this is VPC CIDR"
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

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}
variable "reserve_ip" {
    default = "3"
}
# variable "subnet_az_map" {
#   description = "A map of subnets to availability zones"
#   type        = map(string)
# }