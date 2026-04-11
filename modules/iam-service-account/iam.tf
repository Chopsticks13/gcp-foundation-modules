locals {
  iam_additive_pairs = flatten([
    for role, members in var.iam_additive : [
      for member in members : {
        role   = role
        member = member
      }
    ]
  ])

  iam_project_pairs = flatten([
    for project, roles in var.iam_project_roles : [
      for role in roles : {
        project = project
        role    = role
      }
    ]
  ])
}

# Authoritative IAM ON the service account (who can act as / impersonate it).
resource "google_service_account_iam_binding" "authoritative" {
  for_each = var.iam

  service_account_id = google_service_account.sa.name
  role               = each.key
  members            = each.value
}

# Additive IAM ON the service account.
resource "google_service_account_iam_member" "additive" {
  for_each = {
    for pair in local.iam_additive_pairs :
    "${pair.role}--${pair.member}" => pair
  }

  service_account_id = google_service_account.sa.name
  role               = each.value.role
  member             = each.value.member
}

# Project-level roles granted TO the service account (what it can do).
resource "google_project_iam_member" "project_roles" {
  for_each = {
    for pair in local.iam_project_pairs :
    "${pair.project}--${pair.role}" => pair
  }

  project = each.value.project
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.sa.email}"
}
