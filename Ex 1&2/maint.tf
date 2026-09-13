module "vpc" {
  source = "./modules/VPC"

  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  public_subnets        = var.public_subnets
  private_subnets       = var.private_subnets
  endpoints             = var.endpoints
  stage                 = var.stage
  enable_flow_logs      = var.enable_flow_logs
  log_retention_in_days = var.log_retention_in_days
}

module "backup_s3" {
  source = "./modules/Backup-S3"

  bucket_name                            = var.backup_bucket_name
  environment                            = var.stage
  transition_to_glacier_days             = var.transition_to_glacier_days
  retention_days                         = var.retention_days
  noncurrent_version_expiration_days     = var.noncurrent_version_expiration_days
  uploader_role_arns                     = var.uploader_role_arns
  enable_versioning                      = var.enable_versioning
  abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload_days
}