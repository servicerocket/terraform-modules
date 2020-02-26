# v3/iam-basic

variable "json_switch_role_policy" {}
variable "policy_arn_member" { default = "arn:aws:iam::aws:policy/job-function/SupportUser" }

output "aws_iam_role_administrator" { value = aws_iam_role.administrator.id }
output "aws_iam_role_power_user" { value = aws_iam_role.power_user.id }
output "aws_iam_role_member" { value = aws_iam_role.member.id }

## Groups & Group Policies

resource "aws_iam_group" "administrators" {
  name = "Administrators"
  path = "/teams/"
}

resource "aws_iam_group" "bots" {
  name = "Bots"
  path = "/bots/"
}

resource "aws_iam_group" "collaborators" {
  name = "Collaborators"
  path = "/teams/"
}

resource "aws_iam_group" "managers" {
  name = "Managers"
  path = "/teams/"
}

resource "aws_iam_group" "users" {
  name = "Users"
  path = "/teams/"
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group = aws_iam_group.administrators.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "users" {
  group = aws_iam_group.users.id
  policy_arn = "arn:aws:iam::aws:policy/job-function/SupportUser"
}

## Roles & Role Policies

resource "aws_iam_role" "administrator" {
  name = "Administrator"
  assume_role_policy = var.json_switch_role_policy
}

resource "aws_iam_role" "power_user" {
  name = "PowerUser"
  assume_role_policy = var.json_switch_role_policy
}

resource "aws_iam_role" "manager" {
  name = "Manager"
  assume_role_policy = var.json_switch_role_policy
}

resource "aws_iam_role" "member" {
  name = "Member"
  assume_role_policy = var.json_switch_role_policy
}

resource "aws_iam_role_policy_attachment" "administrator" {
  role = aws_iam_role.administrator.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "billing_for_administrator" {
  role = aws_iam_role.administrator.id
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_role_policy_attachment" "billing_ec2reports_for_administrator" {
  role = aws_iam_role.administrator.id
  policy_arn = "arn:aws:iam::aws:policy/AWSAccountUsageReportAccess"
}

resource "aws_iam_role_policy_attachment" "power_user" {
  role = aws_iam_role.power_user.id
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy_attachment" "member" {
  role = aws_iam_role.member.id
  policy_arn = var.policy_arn_member
}
