# Full ssh key example

Supply `public_keys` as a map of stable owner identifiers to OpenSSH public key contents. The example
uses every module input, constructs names from the map keys, and combines shared and per-key labels.

Use the `ids` output when creating servers, or `public_keys` for a Storage Box's initial SSH keys.
Changing registered public keys does not update access on existing servers.

## Running the example

Export `HCLOUD_TOKEN`, supply the inputs described in `variables.tf`, then run:

```shell
terraform init
terraform plan
terraform apply
```

This creates real infrastructure. Review the plan and any deletion protection before cleanup.
See the [module README](../../README.md) for usage and input descriptions.
