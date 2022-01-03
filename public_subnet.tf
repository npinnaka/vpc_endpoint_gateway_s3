resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "VPC-IGW"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${var.az}"
  tags = {
    Name = "VPC-Public-Subnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.all_traffic
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "VPC-Public-Route-Table"
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route_table_association" "public_route_table_mapping" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}