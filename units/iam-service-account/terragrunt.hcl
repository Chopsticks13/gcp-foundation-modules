terraform {
  source = "${get_repo_root()}/modules//iam-service-account"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = {
  project_id   = dependency.project.outputs.project_id
  name         = values.sa_name
  display_name = try(values.sa_display_name, null)
  description  = try(values.sa_description, "Managed by Terraform.")

  iam_project_roles = try(values.sa_project_roles, {})
}
