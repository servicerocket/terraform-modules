# v3/iam-idp/google

variable "path_saml_metadata" { default = "./saml.xml" }


resource "aws_iam_saml_provider" "google" {
  name = "Google"
  saml_metadata_document = file(var.path_saml_metadata)
}
