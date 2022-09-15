resource "aws_iam_role" "koria_iam_role" {
  name = "koria_iam_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "koria_iam_role"
  }
}

#policy to attach the s3bucket role
resource "aws_iam_role_policy" "koria_s3_role_policy"{
    name = "koria_s3_role_policy"
    role = aws_iam_role.koria_iam_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = [
                    "arn:aws:s3:::koria-s3-bucket",
                    "arn:aws:s3:::koria-s3-bucket/*"
                ] 
      },
    ]
  })
}


resource "aws_iam_instance_profile" "koria_s3_role_instance"{
    name = "koria_s3_role_instance"
    role = aws_iam_role.koria_iam_role.name
}