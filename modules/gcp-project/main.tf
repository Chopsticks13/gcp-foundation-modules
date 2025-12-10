/**
 * GCP Project Module - Core Resources
 * 
 * Creates a GCP project with proper organization
 * Based on Google FAST methodology
 */

locals {
  # Standard labels for all projects
  standard_labels = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      team        = var.team
      cost_center = var.cost_center
    },
    var.labels
  )
}

# Create the GCP project
resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  folder_id       = var.folder_id # Will be null for non-org accounts
  billing_account = var.billing_account

  labels = local.standard_labels

  auto_create_network = false

  lifecycle {
    prevent_destroy = false
  }
}

# Small delay after project creation for eventual consistency
resource "time_sleep" "project_creation" {
  depends_on = [google_project.project]

  create_duration = "30s"
}