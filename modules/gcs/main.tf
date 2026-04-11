resource "google_storage_bucket" "bucket" {
  project       = var.project_id
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
  force_destroy = var.force_destroy
  labels        = var.labels

  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lifecycle_rule.value.action.storage_class
      }
      condition {
        age                   = lifecycle_rule.value.condition.age
        created_before        = lifecycle_rule.value.condition.created_before
        num_newer_versions    = lifecycle_rule.value.condition.num_newer_versions
        matches_storage_class = lifecycle_rule.value.condition.matches_storage_class
        with_state            = lifecycle_rule.value.condition.with_state
      }
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy != null ? [var.retention_policy] : []
    content {
      retention_period = retention_policy.value.retention_period
      is_locked        = retention_policy.value.is_locked
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key != null ? [var.encryption_key] : []
    content {
      default_kms_key_name = encryption.value
    }
  }
}
