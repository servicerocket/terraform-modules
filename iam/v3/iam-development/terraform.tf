# v3/iam-development

variable "path_switch_role_policy" { default = "../switch-role-policy.json" }
variable "path_switch_role_with_saml_policy" { default = "../switch-role-with-saml-policy.json" }
variable "policy_arn_developer" { default = "arn:aws:iam::aws:policy/PowerUserAccess" }

output "aws_iam_role_developer" { value = aws_iam_role.developer.id }

resource "aws_iam_group" "developers" {
  name = "Developers"
  path = "/teams/"
}

resource "aws_iam_group" "system_operators" {
  name = "SystemOperators"
  path = "/teams/"
}

resource "aws_iam_group_policy_attachment" "sysadmin_for_system_operators" {
  group = aws_iam_group.system_operators.id
  policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
}

resource "aws_iam_group_policy_attachment" "developers" {
  group = aws_iam_group.developers.id
  policy_arn = var.policy_arn_developer
}


resource "aws_iam_group_policy_attachment" "git_for_developers" {
  group = aws_iam_group.developers.id
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

resource "aws_iam_role" "developer" {
  name = "Developer"
  assume_role_policy = file(var.path_switch_role_with_saml_policy)
}

resource "aws_iam_role_policy_attachment" "developer" {
  role = aws_iam_role.developer.id
  policy_arn = var.policy_arn_developer
}

resource "aws_iam_role_policy_attachment" "git_for_developer" {
  role =aws_iam_role.developer.id
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}
