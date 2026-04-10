output "email" {
  description = "Service account email."
  value       = google_service_account.sa.email
}

output "id" {
  description = "Fully qualified service account ID."
  value       = google_service_account.sa.id
}

output "member" {
  description = "IAM member string (serviceAccount:email)."
  value       = "serviceAccount:${google_service_account.sa.email}"
}

output "name" {
  description = "Service account resource name."
  value       = google_service_account.sa.name
}
