# v3/iam-idp/okta/master

variable "path_saml_metadata" { default = "./saml.xml" }

resource "aws_iam_user" "okta" {
  name = "okta.bot"
  path = "/bots/"
}

resource "aws_iam_user_policy" "okta_master" {
  user = aws_iam_user.okta.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sts:AssumeRole",
        "sts:AssumeRoleWithSAML",
        "iam:GetAccountSummary",
        "iam:GetUser",
        "iam:ListAccountAliases",
        "iam:ListRoles"
        ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_group_membership" "okta" {
  user = aws_iam_user.okta.name

  groups = [
    "Bots"
  ]
}

resource "aws_iam_saml_provider" "okta" {
  name = "Okta"
  saml_metadata_document = file(var.path_saml_metadata)
}
