output "ids" {
  description = "SSH key IDs keyed by caller identifiers."
  value       = module.ssh_keys.ids
}
