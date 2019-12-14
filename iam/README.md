# Standard IAM

These modules help to bootstrap default IAM groups, roles, etc. and related resources (e.g. CodeCommit access).

Please use Root access key to operate.

## Usage

Add the following modules to your `*.tf` file.

```
module "iam-basic" {
  source = ".modules/iam/v3/iam-basic"
  path_switch_role_with_saml_policy = ".modules/iam/v3/switch-role-with-saml-policy.json"
}

module "iam-audit" {
  source = ".modules/iam/v3/iam-audit"
  path_switch_role_policy = ".modules/iam/v3/switch-role-policy.json"
  path_switch_role_with_saml_policy = ".modules/iam/v3/switch-role-with-saml-policy.json"
}

...

```
