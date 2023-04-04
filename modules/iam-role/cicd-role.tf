#Note: will need to come back in and clean up the iam portion of this policy later

resource "aws_iam_instance_profile" "cicd-role" {
  name = aws_iam_role.cicd-role.name
  role = aws_iam_role.cicd-role.name
  depends_on = [
    aws_iam_role.cicd-role
  ]
}

#Note: Apply Sid 1 first, then go back and apply Sid 2 and Sid 3.  2 and 3 are dependent on the principal being created.
resource "aws_iam_role" "cicd-role" {
  name = "${var.role-name}"
  managed_policy_arns = ["arn:aws:iam::aws:policy/PowerUserAccess"]
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": [
                        "${var.repository}"
                        ]
                }
            }
        },
        {
            "Sid": "2",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-reserved/sso.amazonaws.com/${local.AWSReservedSSO_AdministratorAccess}"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  inline_policy {
    name = "iam"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "iam",
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": "*"
        }
    ]
}
    EOF
  }
}

#===========================================================
# {
#     "Sid": "3",
#     "Effect": "Allow",
#     "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/cicd-role"
#     },
#     "Action": "sts:AssumeRole"
# }