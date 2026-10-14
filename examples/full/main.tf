module "ssh_keys" {
  source = "../.."
  labels = { environment = "production", managed_by = "terraform" }
  keys = {
    for name, public_key in var.public_keys : name => {
      name       = "ops-${name}"
      public_key = public_key
      labels     = { owner = name }
    }
  }
}
