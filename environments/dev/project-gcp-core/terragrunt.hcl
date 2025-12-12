# Dev Project Example

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules//gcp-project"
}

# Load environment config
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  org_vars = read_terragrunt_config(find_in_parent_folders("org.hcl"))
  
}

inputs = {
  # Project basics
  project_name = "GCP Core Project"
  project_id   = "dev-gcp-core"
  
  # Organization
  folder_id       = local.env_vars.locals.folder_id
  billing_account = local.org_vars.locals.billing_account
  
  # Metadata
  environment = local.env_vars.locals.environment  # From env.hcl instead of hardcoded
  team        = "platform"
  cost_center = "cc-00001"
  
  # Additional labels
  labels = {
    purpose = "core-infrastructure"
  }
  
  # Enable services
  enable_compute        = true
  enable_logging        = true
  enable_monitoring     = true
  enable_secret_manager = true
  
  # IAM bindings
  iam_bindings = {}
  
  # Service accounts - better naming
  service_accounts = {
    "dev-gcp-core-sa" = {
      display_name = "GCP Core Service Account"
      description  = "Primary SA for core infrastructure"
      roles        = []
    }
  }
}
