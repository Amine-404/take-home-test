variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "stage" {
  description = "The stage of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = "A map of public subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "A map of private subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "endpoints" {
  description = "A map of VPC endpoints to create"
  type = map(object({
    service_name        = string
    vpc_endpoint_type   = string
    private_dns_enabled = optional(bool, true)
    security_group_ids  = optional(list(string))
    subnet_ids          = optional(list(string))
    policy              = optional(string)
  }))
  default = {}
}

variable "enable_flow_logs" {
  description = "A boolean flag to enable/disable VPC flow logs"
  type        = bool
}

variable "log_retention_in_days" {
  description = "The number of days to retain the flow logs in CloudWatch Logs"
  type        = number
}
