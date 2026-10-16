# Hetzner SSH Key Terraform module

Manage any number of SSH public keys with shared labels and per-key names and labels.

## Usage

Copy this configuration into `main.tf` and add the
[provider configuration](#provider-configuration) below in `versions.tf`.

```hcl
module "ssh_keys" {
  source = "terraform-hetzner-modules/ssh-key/hetzner"

  keys = {
    laptop = {
      public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
    }
  }
}
```

The public key file must already exist. Reference `module.ssh_keys.ids.laptop` when creating servers.
This module registers public keys; it does not generate key pairs.

## Provider configuration

Export your Hetzner API token as `HCLOUD_TOKEN`. Put the following in your calling root's `versions.tf`:

```hcl
terraform {
  required_version = ">= 1.7"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.70"
    }
  }
}

provider "hcloud" {}
```

With both files in place, run `terraform init`, `terraform plan`, and `terraform apply`.
Credentials and provider configuration belong in the calling root.
Terraform >= 1.7 and OpenTofu >= 1.8 are supported.

## Examples

- [Basic](examples/basic): multiple public keys.
- [Full](examples/full): every input, generated names, and shared and per-key labels.

## Managing keys

One invocation manages any number of keys through the `keys` map; an empty map creates none.
Map keys are stable resource addresses and must be known during planning. Public key contents may
be computed. Each key's Hetzner name defaults to its map key; per-key labels override shared labels.
Keep map keys stable when renaming keys in Hetzner to avoid unnecessary replacement.

The `ids`, `names`, `fingerprints`, `public_keys`, and `labels` outputs use the same map keys.
The `keys` output exposes the complete resource objects. Use `values(module.ssh_keys.ids)` with a
server module's `ssh_keys`, or `values(module.ssh_keys.public_keys)` for a Storage Box's initial keys.
Private keys are neither generated nor accepted by this module.

Changing a public key replaces its registered key. Registering or updating a key does not update
SSH access on existing servers; injected server keys are configured when the server is created.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.7 |
| hcloud | ~> 1.70 |

## Providers

| Name | Version |
| ---- | ------- |
| hcloud | ~> 1.70 |

## Resources

| Name | Type |
| ---- | ---- |
| [hcloud_ssh_key.current](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| keys | SSH public keys keyed by stable identifiers. Names default to map keys; per-key labels override shared labels. | ```map(object({ name = optional(string) public_key = string labels = optional(map(string), {}) }))``` | `{}` | no |
| labels | Labels shared by all SSH keys. Per-key labels take precedence. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| fingerprints | SSH public key fingerprints indexed by the caller's stable keys. |
| ids | SSH key IDs indexed by the caller's stable keys. |
| keys | Complete SSH key attributes indexed by the caller's stable keys. |
| labels | Merged labels indexed by the caller's stable keys. |
| names | SSH key names indexed by the caller's stable keys. |
| public\_keys | SSH public keys indexed by the caller's stable keys. |
<!-- END_TF_DOCS -->

## Contributing

See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for local checks and contribution guidelines, and
[UPGRADING.md](docs/UPGRADING.md) for compatibility and live acceptance checks. The generated
[schema report](docs/SCHEMA.md) documents provider coverage and intentional omissions.

## Authors

Maintained by [Terraform Hetzner Modules](https://github.com/terraform-hetzner-modules).
See [AUTHORS](.github/AUTHORS) and [CODEOWNERS](.github/CODEOWNERS).

## License

MIT. See [LICENSE](LICENSE).
