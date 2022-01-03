resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  public_key = tls_private_key.private_key.public_key_openssh
  key_name   = "narenkp"
  tags = {
    Name = "VPC-KeyPair"
  }
}

resource "local_file" "key" {
  filename = "./narenkp.pem"
  content  = tls_private_key.private_key.private_key_pem
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "sample-bucket-20220102050000"
}

resource "aws_s3_bucket_public_access_block" "pab" {
  bucket                  = aws_s3_bucket.bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



