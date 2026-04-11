terraform {
  source = "${get_repo_root()}/modules//gcs"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "org" {
  path   = find_in_parent_folders("org.hcl")
  expose = true
}

dependency "project" {
  config_path = "../project"

  mock_outputs = {
    project_id = "mock-project-id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  project_id    = dependency.project.outputs.project_id
  name          = values.bucket_name
  location      = include.org.locals.default_region
  storage_class = try(values.storage_class, "STANDARD")
  versioning    = try(values.versioning, true)
  force_destroy = try(values.force_destroy, false)

  labels = {
    environment = values.environment
    managed_by  = "terraform"
  }
}
