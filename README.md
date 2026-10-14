<p align="center">
    <!-- terraform-hetzner-ssh-key -->
<img src="https://cdn.simpleicons.org/terraform/844FBA" alt="Terraform Logo" align="center" width="128">
<img src="https://avatars.githubusercontent.com/u/30047064?s=200&v=4" alt="Hetzner Logo" align="center" width="128">
    <h1 align="center">Hetzner Cloud</h1>
    <h2 align="center"><code>ssh-key</code></h2>
</p>

[![License](https://img.shields.io/github/license/terraform-hetzner-modules/terraform-hetzner-ssh-key?label=License)](https://opensource.org/licenses/MIT)
[![Terraform](https://img.shields.io/badge/Terraform-_>=_1.7-brightgreen?logo=terraform&logoColor=623CE4)][terraform]
[![Opentofu](https://img.shields.io/badge/OpenTofu-_>=_1.8-brightgreen?logo=opentofu)][opentofu]
[![CI Status](https://github.com/terraform-hetzner-modules/terraform-hetzner-ssh-key/actions/workflows/testing.yaml/badge.svg)](https://github.com/terraform-hetzner-modules/terraform-hetzner-ssh-key/blob/main/.github/workflows/testing.yaml)
[![GitHub Release](https://img.shields.io/github/v/release/terraform-hetzner-modules/terraform-hetzner-ssh-key?label=Release)][github_releases]
[![GitHub Activity](https://img.shields.io/github/commit-activity/m/terraform-hetzner-modules/terraform-hetzner-ssh-key?label=Commits)][github_commits]
[![Renovate](https://img.shields.io/badge/Renovate-enabled-brightgreen?logo=renovate&logoColor=1A1F6C)][renovate]
[![Pre-Commit](https://img.shields.io/badge/PreCommit-enabled-brightgreen?logo=precommit&logoColor=FAB040)][pre-commit]

A [Terraform module][module] to manage a collection of SSH public keys in [Hetzner Cloud][hetzner].

## ✨ TL;DR

```hcl
module "ssh_keys" {
  source = "terraform-hetzner-modules/ssh-key/hetzner"

  labels = { managed_by = "terraform" }
  keys = {
    administrator = {
      public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
    }
    automation = {
      name       = "ci-deploy"
      public_key = var.automation_public_key
      labels     = { purpose = "deployment" }
    }
  }
}
```

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

## Compatibility and examples

Requires Terraform >= 1.7 (OpenTofu >= 1.8 tested) and hcloud ~> 1.70.
See [basic](examples/basic) and [full](examples/full) examples; configure credentials through `HCLOUD_TOKEN`.
The generated [schema report](docs/SCHEMA.md) records provider fields and module mappings.
See the [maintenance and upgrade guide](docs/UPGRADING.md) for validation and coverage checks.
Run `terraform init -backend=false`, `terraform validate`, and `terraform test`
for credential-free validation and mocked tests.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.70 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_keys"></a> [keys](#input\_keys) | SSH public keys keyed by stable identifiers. Names default to map keys; per-key labels override shared labels. | ```map(object({ name = optional(string) public_key = string labels = optional(map(string), {}) }))``` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels shared by all SSH keys. Per-key labels take precedence. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_fingerprints"></a> [fingerprints](#output\_fingerprints) | SSH public key fingerprints indexed by the caller's stable keys. |
| <a name="output_ids"></a> [ids](#output\_ids) | SSH key IDs indexed by the caller's stable keys. |
| <a name="output_keys"></a> [keys](#output\_keys) | Complete SSH key attributes indexed by the caller's stable keys. |
| <a name="output_labels"></a> [labels](#output\_labels) | Merged labels indexed by the caller's stable keys. |
| <a name="output_names"></a> [names](#output\_names) | SSH key names indexed by the caller's stable keys. |
| <a name="output_public_keys"></a> [public\_keys](#output\_public\_keys) | SSH public keys indexed by the caller's stable keys. |
<!-- END_TF_DOCS -->

### 🔃 Contributing

Refer to our [documentation for contributors][contributing] for contributing guidelines, commit message
formats and versioning tips.

### 📥 Maintainers

This project is owned and maintained by [Terraform Hetzner Modules][org]. Refer to the [`AUTHORS`][authors] or [`CODEOWNERS`][owners]
for more information. You may also use the linked contact details to reach out directly.

### ©️ Copyright

- _Assets provided by:_ **[HashiCorp][hashicorp]**
- _Sources provided by:_ **[Terraform Hetzner Modules][org]** under the **[MIT License][license]**

<!-- INTERNAL REFERENCES -->

<!-- Project references -->

<!-- File references -->

[license]: LICENSE
[contributing]: docs/CONTRIBUTING.md
[authors]: .github/AUTHORS
[owners]: .github/CODEOWNERS

<!-- General links -->

[org]: https://github.com/terraform-hetzner-modules
[terraform]: https://terraform.io
[opentofu]: https://opentofu.org/
[hashicorp]: https://www.hashicorp.com/
[hetzner]: https://hetzner.com
[github_releases]: https://github.com/terraform-hetzner-modules/terraform-hetzner-ssh-key/releases
[github_commits]: https://github.com/terraform-hetzner-modules/terraform-hetzner-ssh-key/commits/main/

<!-- Third-party -->

[module]: https://registry.terraform.io/modules/terraform-hetzner-modules/ssh-key/hetzner/latest
[renovate]: https://renovatebot.com/
[pre-commit]: https://pre-commit.com/
