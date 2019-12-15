# v3/iam-audit

variable "json_switch_role_policy" {}

output "aws_iam_role_auditor_id" { value = aws_iam_role.auditor.id }
output "aws_iam_role_finance_auditor_id" { value = aws_iam_role.finance_auditor.id }

## Roles & Role Policies

resource "aws_iam_role" "auditor" {
  name = "Auditor"
  assume_role_policy = var.json_switch_role_policy
}

resource "aws_iam_role" "finance_auditor" {
  name = "FinanceAuditor"
  assume_role_policy = var.json_switch_role_policy
}

resource "aws_iam_policy" "finance_auditor" {
  name = "FinancialAuditor"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": "aws-portal:View*",
          "Resource": "*"
      },
      {
          "Effect": "Deny",
          "Action": "aws-portal:*Account",
          "Resource": "*"
      }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "billing_for_finance" {
  role = aws_iam_role.finance_auditor.id
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_role_policy_attachment" "billing_ec2reports_for_finance" {
  role = aws_iam_role.finance_auditor.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReportsAccess"
}

resource "aws_iam_role_policy_attachment" "auditor" {
  role = aws_iam_role.auditor.id
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "finance_auditor" {
  role = aws_iam_role.finance_auditor.id
  policy_arn = aws_iam_policy.finance_auditor.arn
}

resource "aws_iam_role_policy_attachment" "security_auditor" {
  role = aws_iam_role.auditor.id
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
