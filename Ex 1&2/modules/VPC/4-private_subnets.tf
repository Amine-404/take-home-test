resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name  = "${var.vpc_name}-${each.key}"
    Stage = var.stage
    Type  = "private"
  }
}