stage      = "dev"
aws_region = "us-east-1"
vpc_name   = "main-vpc"
vpc_cidr   = "10.0.0.0/16"

public_subnets = {
  "public-subnet-1" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  }
  "public-subnet-2" = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  }
}

private_subnets = {
  "private-subnet-1" = {
    cidr_block        = "10.0.10.0/24"
    availability_zone = "us-east-1a"
  }
  "private-subnet-2" = {
    cidr_block        = "10.0.11.0/24"
    availability_zone = "us-east-1b"
  }
}

endpoints = {
  "s3" = {
    service_name      = "s3"
    vpc_endpoint_type = "Gateway"
  }
}
enable_flow_logs      = true
log_retention_in_days = 14


backup_bucket_name                     = "my-backup-bucket-take-home-test-dev"
transition_to_glacier_days             = 60
retention_days                         = 180
noncurrent_version_expiration_days     = 0
uploader_role_arns                     = ["arn:aws:iam::123456789012:role/backup_uploader"]
enable_versioning                      = true
abort_incomplete_multipart_upload_days = 7  