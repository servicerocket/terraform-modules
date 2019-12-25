# v3/iam-idp/okta/secondary

variable "aws_parent_account_id" {}
variable "path_saml_metadata" { default = "./saml.xml" }

resource "aws_iam_saml_provider" "okta" {
  name = "Okta"
  saml_metadata_document = file(var.path_saml_metadata)
}

resource "aws_iam_role" "Okta-Idp-cross-account-role" {
  name = "Okta-Idp-cross-account-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${aws_parent_account_id}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
