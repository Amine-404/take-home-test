variable "aws_region" {
  type = string
}

variable "stage" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "endpoints" {
  type = map(object({
    service_name        = string
    vpc_endpoint_type   = string
    private_dns_enabled = optional(bool, true)
    security_group_ids  = optional(list(string))
    subnet_ids          = optional(list(string))
    policy              = optional(string)
  }))
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}


variable "enable_flow_logs" {
  type = bool
}

variable "log_retention_in_days" {
  type = number
}

variable "backup_bucket_name" {
  type = string
}

variable "transition_to_glacier_days" {
  type = number
}

variable "retention_days" {
  type = number
}

variable "noncurrent_version_expiration_days" {
  type = number
}

variable "uploader_role_arns" {
  type = list(string)
}

variable "enable_versioning" {
  type = bool
}

variable "abort_incomplete_multipart_upload_days" {
  type = number
}