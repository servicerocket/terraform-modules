# v3/iam-idp/okta/secondary

variable "aws_parent_account_id" {}
variable "path_saml_metadata" { default = "./saml.xml" }

resource "aws_iam_role" "okta_master" {
  name = "Okta-Idp-cross-account-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_parent_account_id}:root"
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy" "okta_master" {
  name = "OktaMasterLimitedReadAccess"
  description = "Permissions grantaed to Master account to set up the Connected Accounts."
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:ListAccountAliases",
        "iam:ListRoles"
        ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "okta_master" {
  role       = aws_iam_role.okta_master.name
  policy_arn = aws_iam_policy.okta_master.arn
}

resource "aws_iam_saml_provider" "okta" {
  name = "Okta"
  saml_metadata_document = file(var.path_saml_metadata)
}
