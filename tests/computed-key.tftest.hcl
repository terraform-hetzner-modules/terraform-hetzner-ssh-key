mock_provider "hcloud" {}

run "computed_public_key_is_plannable" {
  command = plan
  module { source = "./tests/setup" }
  assert {
    condition     = output.names.computed == "computed"
    error_message = "A computed public key must not make the resource address unknown."
  }
}
