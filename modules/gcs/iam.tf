resource "google_storage_bucket_iam_binding" "authoritative" {
  for_each = var.iam

  bucket  = google_storage_bucket.bucket.name
  role    = each.key
  members = each.value
}
