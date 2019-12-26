# Standard IAM

These modules help to bootstrap default IAM groups, roles, etc. and related resources (e.g. CodeCommit access).

Please use Root access key to operate.

## Usage

Add the following modules to your `*.tf` file.

```
module "iam-basic" {
  source = "../.modules/v3/iam-basic"
  json_switch_role_policy = templatefile("../.modules/v3/iam-idp/okta/switch-role-with-saml-policy.json", {
    aws_account_id = data.aws_caller_identity.current.account_id
  })
}

module "iam-idp-okta" {
  source = "../.modules/v3/iam-idp/okta/master"
  path_saml_metadata = "./saml.xml"
}


module "iam-audit" {
  source = "../.modules/v3/iam-audit"
  json_switch_role_policy = templatefile("../.modules/v3/iam-idp/okta/switch-role-with-saml-policy.json", {
    aws_account_id = data.aws_caller_identity.current.account_id
  })
}
...

```

If a resource already exists, you might hit into conflicts if you proceed. Prevent this by importing:

    terraform import  <object_ref> <id|arn>

For example:

    terraform import module.iam-idp-okta.aws_iam_user.okta okta.bot
    terraform import  aws_iam_saml_provider.okta arn:aws:iam::<aws_account_id>:saml-provider/Okta

