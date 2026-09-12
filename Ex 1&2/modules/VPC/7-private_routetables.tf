resource "aws_route_table" "private" {
  for_each = var.private_subnets
  vpc_id   = aws_vpc.main.id

  tags = {
    Name  = "${var.vpc_name}-private-rt-${each.key}"
    Stage = var.stage
  }
}

resource "aws_route" "private_nat_access" {
  count = length(var.private_subnets)

  route_table_id         = aws_route_table.private[keys(var.private_subnets)[count.index]].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[keys(var.public_subnets)[count.index]].id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}