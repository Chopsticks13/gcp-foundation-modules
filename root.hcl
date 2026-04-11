# Root Terragrunt Configuration
# Shared configuration for all units

locals {
  org_vars = read_terragrunt_config(find_in_parent_folders("org.hcl"))
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "google" {
      region = "${local.org_vars.locals.default_region}"
    }

    provider "google-beta" {
      region = "${local.org_vars.locals.default_region}"
    }
  EOF
}

# Configure remote state in GCS
remote_state {
  backend = "gcs"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    project  = local.org_vars.locals.terraform_state_project
    bucket   = local.org_vars.locals.terraform_state_bucket
    prefix   = "${path_relative_to_include()}/terraform.tfstate"
    location = local.org_vars.locals.default_region
  }
}
