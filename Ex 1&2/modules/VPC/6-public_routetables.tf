resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name  = "${var.vpc_name}-public-rt"
    Stage = var.stage
  }
}

resource "aws_route" "public_internet_access" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}