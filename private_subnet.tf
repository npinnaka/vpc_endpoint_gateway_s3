resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "VPC-Private-Subnet"
  }
}

#s3 prelix list for endpoint will be added.
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "VPC-Private-Subnet-Route-Table"
  }
}

resource "aws_route_table_association" "private_route_table_mapping" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet.id
}