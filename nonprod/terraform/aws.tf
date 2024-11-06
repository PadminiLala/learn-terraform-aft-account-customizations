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