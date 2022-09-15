resource "aws_iam_user" "koria_iam"{
    name="koria_iam"
}

resource "aws_iam_user" "keita_iam"{
    name="keita_iam"
}

resource "aws_iam_group" "family_only_group"{
    name="family_only_group"
}

resource "aws_iam_group_membership" "family-only-allowed"{
    name = "family-only-allowed"
    users = [aws_iam_user.koria_iam.name,aws_iam_user.keita_iam.name]
    group = aws_iam_group.family_only_group.name
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "family-only-attach"{
   name = "family-only-attach"
   groups = [aws_iam_group.family_only_group.name]
   policy_arn = aws_iam_policy.policy.arn
}



