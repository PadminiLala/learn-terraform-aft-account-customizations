
# Create a Virtual Private Cloud
module "vpc" {
  source        = "../../modules/"
  network_view     = "default"
  container_cidr   = "10.117.0.0/24"
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

resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "vpc_flow_logs_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "FlowLogsS3Access"
  description = "Policy for VPC Flow Logs to write to S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:PutObject"
        Resource = "arn:aws:s3:::vpc-flowlogs-s3-test/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_flow_logs_policy" {
  role       = aws_iam_role.vpc_flow_logs_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_flow_log" "example" {
  traffic_type = "ALL"
  vpc_id = module.vpc.vpc_id 
  iam_role_arn = aws_iam_role.vpc_flow_logs_role.arn
  log_destination_type = "s3"
  log_destination = "arn:aws:s3:::vpc-flowlogs-s3-test"
}