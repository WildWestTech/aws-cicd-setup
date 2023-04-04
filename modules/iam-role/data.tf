#data.aws_caller_identity.current.account_id
data "aws_caller_identity" "current" {}


data "aws_iam_roles" "AWSReservedSSO_AdministratorAccess" {
  name_regex  = "AWSReservedSSO_AdministratorAccess_.*"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

locals {
  AWSReservedSSO_AdministratorAccess = join("", data.aws_iam_roles.AWSReservedSSO_AdministratorAccess.names)
}