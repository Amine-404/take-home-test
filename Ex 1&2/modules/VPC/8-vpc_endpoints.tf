resource "aws_vpc_endpoint" "main" {
  for_each = var.endpoints

  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.${each.value.service_name}"
  vpc_endpoint_type = each.value.vpc_endpoint_type

  subnet_ids          = each.value.vpc_endpoint_type == "Interface" ? coalesce(each.value.subnet_ids, [for subnet in aws_subnet.private : subnet.id]) : null
  security_group_ids  = each.value.vpc_endpoint_type == "Interface" ? each.value.security_group_ids : null
  private_dns_enabled = each.value.vpc_endpoint_type == "Interface" ? each.value.private_dns_enabled : null

  route_table_ids = each.value.vpc_endpoint_type == "Gateway" ? concat([for rt in aws_route_table.private : rt.id], [aws_route_table.public.id]) : null

  policy = each.value.policy

  tags = {
    Name  = "${var.vpc_name}-vpc-endpoint-${each.key}"
    Stage = var.stage
  }
}