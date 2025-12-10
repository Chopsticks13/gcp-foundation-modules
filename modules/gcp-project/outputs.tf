/**
 * Output Values
 */

output "project_id" {
  description = "Project ID"
  value       = google_project.project.project_id
}

output "project_number" {
  description = "Project number"
  value       = google_project.project.number
}

output "project_name" {
  description = "Project name"
  value       = google_project.project.name
}

output "enabled_apis" {
  description = "List of enabled APIs"
  value       = [for api in google_project_service.apis : api.service]
}

output "service_accounts" {
  description = "Created service accounts"
  value = {
    for k, sa in google_service_account.service_accounts : k => {
      email = sa.email
      name  = sa.name
      id    = sa.account_id
    }
  }
}

output "labels" {
  description = "Applied labels"
  value       = local.standard_labels
}