# Root Terragrunt Configuration
# Shared configuration for all child modules

locals {
  # Load organization config
  org_vars = read_terragrunt_config(find_in_parent_folders("org.hcl"))
  
  # Extract environment from path (e.g., environments/dev/project-name)
  path_parts  = split("/", path_relative_to_include())
  environment = try(local.path_parts[1], "unknown")
  
  # Common tags
  common_tags = {
    managed_by  = "terragrunt"
    environment = local.environment
    repository  = "gcp-foundation-modules"
  }
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  # Configuration will be inherited from environment variables
  # Set GOOGLE_APPLICATION_CREDENTIALS or use gcloud auth
}

provider "google-beta" {
  # Beta provider for advanced features
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

# Terraform settings
terraform {
  extra_arguments "common_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
  }
  
  # Format before running
  before_hook "terraform_fmt" {
    commands = ["apply", "plan"]
    execute  = ["terraform", "fmt", "-recursive"]
  }
}

# Common inputs available to all modules
inputs = {
  organization_id = local.org_vars.locals.organization_id
  billing_account = local.org_vars.locals.billing_account
  default_region  = local.org_vars.locals.default_region
  environment     = local.environment
}