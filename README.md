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
