resource "aws_iam_role" "instance_profile_role" {
  name = "ec2-instance-profile"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "instance_profile_role_policy" {
  name = "ec2-instance-profile-s3-write"
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid    = "VisualEditor0",
          Effect = "Allow",
          Action = [
            "s3:List*",
            "s3:Get*",
            "s3:DeleteO*",
            "s3:Describe*",
            "s3:Put*"
          ],
          Resource = "*"
        }
      ]
  })
  role = aws_iam_role.instance_profile_role.id
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = aws_iam_role.instance_profile_role.name
  role = aws_iam_role.instance_profile_role.name
}

