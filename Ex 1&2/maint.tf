module "vpc" {
  source = "./modules/VPC"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  endpoints       = var.endpoints
  stage           = var.stage
}