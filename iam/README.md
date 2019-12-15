# Standard IAM

These modules help to bootstrap default IAM groups, roles, etc. and related resources (e.g. CodeCommit access).

Please use Root access key to operate.

## Usage

Add the following modules to your `*.tf` file.

```
module "iam-basic" {
  source = ".modules/iam/v3/iam-basic"
  json_switch_role_policy = templatefile("../.modules/v3/switch-role-with-saml-policy.json", {
    aws_account_id = data.aws_caller_identity.current.account_id
  })
}

module "iam-audit" {
  source = ".modules/iam/v3/iam-audit"
  json_switch_role_policy = templatefile("../.modules/v3/switch-role-with-saml-policy.json", {
    aws_account_id = data.aws_caller_identity.current.account_id
  })
}

...

```
