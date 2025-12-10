/**
 * Google Cloud APIs
 * Enable required services for the project
 */

locals {
  # Core APIs always enabled
  core_apis = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "iam.googleapis.com",
  ]

  # Conditional APIs based on what's enabled
  conditional_apis = concat(
    var.enable_compute ? ["compute.googleapis.com"] : [],
    var.enable_gke ? ["container.googleapis.com"] : [],
    var.enable_cloud_run ? ["run.googleapis.com"] : [],
    var.enable_cloud_sql ? ["sqladmin.googleapis.com"] : [],
    var.enable_secret_manager ? ["secretmanager.googleapis.com"] : [],
    var.enable_kms ? ["cloudkms.googleapis.com"] : [],
    var.enable_logging ? ["logging.googleapis.com"] : [],
    var.enable_monitoring ? ["monitoring.googleapis.com"] : [],
  )

  # All APIs to enable
  all_apis = distinct(concat(
    local.core_apis,
    local.conditional_apis,
    var.additional_apis
  ))
}

# Enable all required APIs
resource "google_project_service" "apis" {
  for_each = toset(local.all_apis)

  project = google_project.project.project_id
  service = each.value

  # Don't disable on destroy to prevent issues
  disable_on_destroy         = false
  disable_dependent_services = false

  depends_on = [
    google_project.project,
    time_sleep.project_creation
  ]
}

# Wait for APIs to be fully activated
resource "time_sleep" "api_activation" {
  depends_on = [google_project_service.apis]

  create_duration = "30s"
}