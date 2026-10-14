terraform {
  required_version = ">= 1.7"
  required_providers {
    hcloud = { source = "hetznercloud/hcloud", version = "~> 1.70" }
  }
}

resource "terraform_data" "public_key" { input = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4f terraform-test" }

module "subject" {
  source = "../.."
  keys   = { computed = { public_key = terraform_data.public_key.output } }
}

output "names" {
  description = "Names remain known even when public key contents are computed."
  value       = module.subject.names
}
