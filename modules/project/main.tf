locals {
  parent_type = var.parent == null ? null : split("/", var.parent)[0]
  parent_id   = var.parent == null ? null : split("/", var.parent)[1]
}

resource "google_project" "project" {
  name            = var.name
  project_id      = var.project_id
  billing_account = var.billing_account
  folder_id       = local.parent_type == "folders" ? local.parent_id : null
  org_id          = local.parent_type == "organizations" ? local.parent_id : null
  deletion_policy = var.deletion_policy

  auto_create_network = false

  labels = var.labels
}

resource "google_project_service" "services" {
  for_each = toset(var.services)

  project = google_project.project.project_id
  service = each.value

  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_compute_shared_vpc_host_project" "host" {
  count = var.shared_vpc_host ? 1 : 0

  project = google_project.project.project_id

  depends_on = [google_project_service.services]
}

resource "google_compute_shared_vpc_service_project" "service" {
  count = var.shared_vpc_service != null ? 1 : 0

  host_project    = var.shared_vpc_service
  service_project = google_project.project.project_id

  depends_on = [google_project_service.services]
}
