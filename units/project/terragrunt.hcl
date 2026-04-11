terraform {
  source = "${get_repo_root()}/modules//project"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "org" {
  path   = find_in_parent_folders("org.hcl")
  expose = true
}

inputs = {
  project_id      = values.project_id
  name            = values.project_name
  billing_account = include.org.locals.billing_account
  parent          = try(values.parent, null)
  deletion_policy = try(values.deletion_policy, "PREVENT")

  labels = merge(
    {
      environment = values.environment
      managed_by  = "terraform"
      team        = try(values.team, "platform")
    },
    try(values.extra_labels, {})
  )

  services = try(values.services, [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com",
  ])

  iam_additive = try(values.iam_additive, {})
}
