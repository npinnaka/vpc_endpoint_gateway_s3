resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "GetAndList",
        Effect    = "Allow",
        Principal = "*"
        Action = [
          "s3:List*",
          "s3:Get*"
        ]
        Resource = "*"
      },
      {
        Sid       = "PutObjects",
        Effect    = "Allow",
        Principal = "*"
        Action    = [
          "s3:Put*"
        ]
        Resource  = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_vpc_endpoint_route_table_association" "vpce_route_table_mapping" {
  route_table_id  = aws_route_table.private_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
