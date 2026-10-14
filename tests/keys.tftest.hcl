mock_provider "hcloud" {
  mock_resource "hcloud_ssh_key" {
    defaults = { id = "42", fingerprint = "test-fingerprint" }
  }
}

run "empty_keys" {
  command = apply
  assert {
    condition     = length(output.keys) == 0 && length(output.ids) == 0
    error_message = "An empty map must create no keys."
  }
}

run "multiple_keys_and_label_precedence" {
  command = apply
  variables {
    labels = { environment = "shared", managed_by = "terraform" }
    keys = {
      alice = { public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4f terraform-test" }
      bob   = { public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4f terraform-test", name = "bob-laptop", labels = { environment = "personal" } }
      ci    = { public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4f terraform-test", name = "build-agent" }
    }
  }
  assert {
    condition     = keys(output.ids) == ["alice", "bob", "ci"] && output.names.alice == "alice" && output.names.bob == "bob-laptop"
    error_message = "One invocation must preserve map identities and name overrides for multiple keys."
  }
  assert {
    condition     = output.labels.bob.environment == "personal" && output.labels.bob.managed_by == "terraform" && output.labels.alice.environment == "shared"
    error_message = "Per-key labels must override shared labels without dropping other shared labels."
  }
  assert {
    condition     = output.fingerprints.alice == "test-fingerprint" && output.public_keys.alice == var.keys.alice.public_key
    error_message = "Fingerprints and public key contents must be exported."
  }
}

run "retain_one_key" {
  command = apply
  variables {
    keys = { bob = { public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4f terraform-test", name = "renamed-bob" } }
  }
  assert {
    condition     = keys(output.ids) == ["bob"] && output.names.bob == "renamed-bob"
    error_message = "Removing other entries and renaming a key must preserve its caller-selected address."
  }
}

run "reject_blank_key" {
  command = plan
  variables { keys = { invalid = { public_key = "  " } } }
  expect_failures = [var.keys]
}
