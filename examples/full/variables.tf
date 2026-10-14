variable "public_keys" {
  description = "Any number of OpenSSH public keys indexed by stable owner identifiers."
  type        = map(string)
}
