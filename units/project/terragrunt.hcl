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

  # Grant CI/CD SA access to every project (no GCP Org = per-project grants).
  # The SA email comes from org.hcl, not from stack values, to avoid
  # GitHub Actions secret masking breaking the for_each keys.
  iam_additive = {
    "roles/browser"                         = [include.org.locals.cicd_sa]
    "roles/serviceusage.serviceUsageAdmin"  = [include.org.locals.cicd_sa]
    "roles/iam.serviceAccountAdmin"         = [include.org.locals.cicd_sa]
    "roles/storage.admin"                   = [include.org.locals.cicd_sa]
    "roles/resourcemanager.projectIamAdmin" = [include.org.locals.cicd_sa]
  }
}
