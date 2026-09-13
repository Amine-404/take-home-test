variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for the S3 bucket"
  type        = string
}

variable "transition_to_glacier_days" {
  description = "Number of days after which to transition objects to Glacier storage class"
  type        = number
}

variable "retention_days" {
  description = "Number of days after which to delete objects"
  type        = number
}

variable "noncurrent_version_expiration_days" {
  description = "Number of days after which to delete noncurrent versions of objects"
  type        = number
}

variable "uploader_role_arns" {
  description = "List of IAM role ARNs that are allowed to upload to the S3 bucket"
  type        = list(string)
  default     = []
}

variable "enable_versioning" {
  description = "Whether to enable versioning on the S3 bucket"
  type        = bool
}

variable "abort_incomplete_multipart_upload_days" {
  description = "Number of days after which to abort incomplete multipart uploads"
  type        = number
}