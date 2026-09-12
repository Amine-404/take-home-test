output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = one(aws_internet_gateway.main[*].id)
}

output "nat_gateway_ids" {
  description = "The IDs of the NAT Gateways"
  value       = [for nat_gw in aws_nat_gateway.main : nat_gw.id]
}

output "vpc_endpoint_ids" {
  description = "The IDs of the VPC Endpoints"
  value       = [for vpc_endpoint in aws_vpc_endpoint.main : vpc_endpoint.id]
}