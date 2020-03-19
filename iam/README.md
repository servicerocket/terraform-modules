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

## Commands

### Setting up for Terraform

Before working on a Terraform project, you must first initialize (or synchronize) the state to (or from) S3:

    terraform init -backend=true \
      -backend-config="bucket=com.servicerocket.ops.aws.terraform" \
      -backend-config="key=<path>/<env>.tfstate"

Refer to configuration in `*.tf` files for the remote path.

After you have made your changes, ensure that you have Terraform (>= 0.12.14), then apply with:

    terraform plan && terraform apply


### Resolving conflicts caused by existing resources

If a resource already exists, you might hit into conflicts if you proceed. Prevent this by importing:

    terraform import  <object_ref> <id|arn>

For example:

    terraform import module.iam-idp-okta.aws_iam_user.okta okta.bot
    terraform import aws_iam_saml_provider.okta arn:aws:iam::<aws_account_id>:saml-provider/Okta


### Avoiding conflicts with other Terrraform states

If the same resource is managed or migrated to other Terraform state files, remove them from your state (without deletion) with `state rm`, e.g.

     terraform state rm aws_iam_group_membership.bots
