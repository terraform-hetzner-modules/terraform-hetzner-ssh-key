output "ids" {
  description = "Use values(ids) as the server module's ssh_keys input."
  value       = module.ssh_keys.ids
}

output "fingerprints" {
  description = "Fingerprints to verify the registered keys."
  value       = module.ssh_keys.fingerprints
}

output "public_keys" {
  description = "Use values(public_keys) as a Storage Box's initial ssh_keys input."
  value       = module.ssh_keys.public_keys
}
