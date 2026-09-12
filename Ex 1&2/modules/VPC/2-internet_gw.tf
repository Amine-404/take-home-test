resource "aws_internet_gateway" "main" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = {
    Name  = "${var.vpc_name}-igw"
    Stage = var.stage
  }
}