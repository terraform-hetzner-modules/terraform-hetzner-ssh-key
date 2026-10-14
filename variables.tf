variable "keys" {
  description = "SSH public keys keyed by stable identifiers. Names default to map keys; per-key labels override shared labels."
  type = map(object({
    name       = optional(string)
    public_key = string
    labels     = optional(map(string), {})
  }))
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for key in values(var.keys) : try(length(trimspace(key.public_key)) > 0, false)])
    error_message = "Each key must contain a non-empty SSH public key."
  }
}

variable "labels" {
  description = "Labels shared by all SSH keys. Per-key labels take precedence."
  type        = map(string)
  default     = {}
  nullable    = false
}
