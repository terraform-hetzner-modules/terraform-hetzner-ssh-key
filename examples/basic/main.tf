module "ssh_keys" {
  source = "../.."
  keys   = { administrator = { public_key = var.public_key } }
}
