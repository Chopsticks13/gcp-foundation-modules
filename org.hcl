# Organisation Configuration
# Bootstrap project and shared settings for all environments.
#
# The "7x2" suffix exists because GCP project IDs are globally unique.
# "ops-admin" was already taken, so we appended a random suffix.
# This is normal — most GCP orgs have a similar suffix on project IDs.

locals {
  organization_id = null

  billing_account = "018634-AC68FD-0FE666"

  terraform_state_project = "ops-admin-7x2"
  terraform_state_bucket  = "ops-tfstate-7x2"

  default_region = "europe-west2"
}
