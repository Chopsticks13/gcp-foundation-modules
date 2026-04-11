output "id" {
  description = "Full project resource ID (projects/PROJECT_ID)."
  value       = google_project.project.id
}

output "name" {
  description = "Project display name."
  value       = google_project.project.name
}

output "number" {
  description = "Project number."
  value       = google_project.project.number
}

output "project_id" {
  description = "Project ID."
  value       = google_project.project.project_id
}

output "services" {
  description = "Enabled services."
  value       = [for s in google_project_service.services : s.service]
}
