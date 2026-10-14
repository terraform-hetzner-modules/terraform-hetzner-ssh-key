resource "hcloud_ssh_key" "current" {
  for_each = var.keys

  name       = coalesce(each.value.name, each.key)
  public_key = each.value.public_key
  labels     = merge(var.labels, each.value.labels)
}
