resource "google_service_account" "sa" {
  project      = var.project_id
  account_id   = var.name
  display_name = coalesce(var.display_name, var.name)
  description  = var.description
}
