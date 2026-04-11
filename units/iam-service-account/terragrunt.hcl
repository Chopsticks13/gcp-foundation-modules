terraform {
  source = "${get_repo_root()}/modules//iam-service-account"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
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
  project_id   = dependency.project.outputs.project_id
  name         = values.sa_name
  display_name = try(values.sa_display_name, null)
  description  = try(values.sa_description, "Managed by Terraform.")

  iam_project_roles = try(values.sa_project_roles, {})
}
