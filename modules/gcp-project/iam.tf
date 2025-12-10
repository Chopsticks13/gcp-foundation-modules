/**
 * IAM Configuration
 * Project-level IAM and service accounts
 */

# Project IAM bindings
resource "google_project_iam_member" "bindings" {
  for_each = var.iam_bindings

  project = google_project.project.project_id
  role    = each.key
  member  = each.value

  depends_on = [
    google_project_service.apis,
    time_sleep.api_activation
  ]
}

# Service accounts for the project
resource "google_service_account" "service_accounts" {
  for_each = var.service_accounts

  project      = google_project.project.project_id
  account_id   = each.key
  display_name = each.value.display_name
  description  = try(each.value.description, "Managed by Terraform")

  depends_on = [
    google_project_service.apis,
    time_sleep.api_activation
  ]
}

# Service account IAM roles
resource "google_project_iam_member" "sa_roles" {
  for_each = {
    for combo in flatten([
      for sa_key, sa in var.service_accounts : [
        for role in try(sa.roles, []) : {
          key  = "${sa_key}-${role}"
          sa   = sa_key
          role = role
        }
      ]
    ]) : combo.key => combo
  }

  project = google_project.project.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.service_accounts[each.value.sa].email}"

  depends_on = [google_service_account.service_accounts]
}

# Workload Identity bindings (GKE to GSA)
resource "google_service_account_iam_member" "workload_identity" {
  for_each = var.workload_identity_bindings

  service_account_id = google_service_account.service_accounts[each.value.service_account].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${google_project.project.project_id}.svc.id.goog[${each.value.namespace}/${each.value.ksa}]"

  depends_on = [
    google_service_account.service_accounts,
    google_project_service.apis
  ]
}