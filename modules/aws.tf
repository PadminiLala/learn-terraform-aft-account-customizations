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
# resource "aws_iam_role" "vpc_flow_logs_role" {
#   name = "vpc_flow_logs_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Principal = {
#           Service = "vpc-flow-logs.amazonaws.com"
#         }
#         Effect    = "Allow"
#         Sid       = ""
#       },
#     ]
#   })
# }

# resource "aws_iam_policy" "s3_access_policy" {
#   name        = "FlowLogsS3Access"
#   description = "Policy for VPC Flow Logs to write to S3 bucket"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = "s3:*"
#         Resource = "arn:aws:s3:::vpc-flowlogs-s3-test/*"
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "attach_flow_logs_policy" {
#   role       = aws_iam_role.vpc_flow_logs_role.name
#   policy_arn = aws_iam_policy.s3_access_policy.arn
# }

# resource "aws_flow_log" "example" {
#   traffic_type = "ALL"
#   vpc_id = aws_vpc.vpc.id
#   # iam_role_arn = aws_iam_role.vpc_flow_logs_role.arn
#   log_destination_type = "s3"
#   log_destination = "arn:aws:s3:::vpc-flowlogs-s3-test"
#   destination_options {
#     file_format        = "plain-text"
#     per_hour_partition = true
#   }
# }