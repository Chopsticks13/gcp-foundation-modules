output "id" {
  description = "Bucket resource ID."
  value       = google_storage_bucket.bucket.id
}

output "name" {
  description = "Bucket name."
  value       = google_storage_bucket.bucket.name
}

output "self_link" {
  description = "Bucket self link."
  value       = google_storage_bucket.bucket.self_link
}

output "url" {
  description = "Bucket URL (gs://BUCKET_NAME)."
  value       = google_storage_bucket.bucket.url
}
