resource "aws_security_group" "public_sg" {
  name = "VPC-Public-Security-Group"
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.all_traffic]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.all_traffic]
  }
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "VPC-Public-Security-Group"
  }
}

resource "aws_instance" "public_instance" {
  instance_type          = "t2.micro"
  ami                    = var.ami
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.key_pair.key_name
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  tags = {
    name = "VPC-Public-Instance"
  }
}