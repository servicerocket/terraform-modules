# ServiceRocket <3 Terraform

This is a shared repository for reusable Terraform modules. 

We began our Terraform journey years back with "aiur" and over time a small portion of the effort has been mandated or copied to a few projects, e.g. the "root" module (now as "iam").

More to come!


## How to start?

Add as Git submodule to your repository, e.g. 

```
git submodule add git@github.com:servicerocket/terraform-modules.git .modules/svrkt-terraform
Cloning into '/path/to/repo/.modules/svrkt-terraform'...
```

See further instructions in each subdirectory, e.g. [iam/README.md](./iam/README.md).


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
