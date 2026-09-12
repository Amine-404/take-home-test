variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "stage" {
  description = "The stage of the VPC"
  type        = string
  default     = "test"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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
  default = {
    public-subnet-a = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
    public-subnet-b = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    }
  }
}

variable "private_subnets" {
  description = "A map of private subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    private-subnet-a = {
      cidr_block        = "10.0.10.0/24"
      availability_zone = "us-east-1a"
    }
    private-subnet-b = {
      cidr_block        = "10.0.11.0/24"
      availability_zone = "us-east-1b"
    }
  }
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

variable "policy" {
  description = "A map of policies for the VPC endpoints"
  type        = map(string)
  default     = {}
}
