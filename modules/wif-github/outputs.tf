output "provider_name" {
  description = "Full provider resource name. Use as GCP_WORKLOAD_IDENTITY_PROVIDER in GitHub secrets."
  value       = google_iam_workload_identity_pool_provider.provider.name
}

output "sa_email" {
  description = "Service account email. Use as GCP_SERVICE_ACCOUNT in GitHub secrets."
  value       = google_service_account.deploy.email
}
