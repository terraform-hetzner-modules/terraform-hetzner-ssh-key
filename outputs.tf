output "keys" {
  description = "Complete SSH key attributes indexed by the caller's stable keys."
  value       = hcloud_ssh_key.current
}

output "ids" {
  description = "SSH key IDs indexed by the caller's stable keys."
  value       = { for key, value in hcloud_ssh_key.current : key => value.id }
}

output "names" {
  description = "SSH key names indexed by the caller's stable keys."
  value       = { for key, value in hcloud_ssh_key.current : key => value.name }
}

output "fingerprints" {
  description = "SSH public key fingerprints indexed by the caller's stable keys."
  value       = { for key, value in hcloud_ssh_key.current : key => value.fingerprint }
}

output "public_keys" {
  description = "SSH public keys indexed by the caller's stable keys."
  value       = { for key, value in hcloud_ssh_key.current : key => value.public_key }
}

output "labels" {
  description = "Merged labels indexed by the caller's stable keys."
  value       = { for key, value in hcloud_ssh_key.current : key => value.labels }
}
