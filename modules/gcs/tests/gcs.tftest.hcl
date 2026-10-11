mock_provider "google" {}

variables {
  name       = "test-bucket-tftest"
  project_id = "test-project-01"
  location   = "europe-west2"
}

run "minimal_plan" {
  command = plan

  assert {
    condition     = google_storage_bucket.bucket.name == "test-bucket-tftest"
    error_message = "bucket name mismatch"
  }

  assert {
    condition     = google_storage_bucket.bucket.location == "europe-west2"
    error_message = "location mismatch"
  }

  assert {
    condition     = google_storage_bucket.bucket.storage_class == "STANDARD"
    error_message = "default storage_class should be STANDARD"
  }

  assert {
    condition     = google_storage_bucket.bucket.uniform_bucket_level_access == true
    error_message = "uniform_bucket_level_access should be enforced"
  }

  assert {
    condition     = google_storage_bucket.bucket.force_destroy == false
    error_message = "default force_destroy should be false"
  }
}

run "with_versioning" {
  command = plan

  variables {
    versioning = true
  }

  assert {
    condition     = google_storage_bucket.bucket.versioning[0].enabled == true
    error_message = "versioning should be enabled"
  }
}

run "with_lifecycle_rules" {
  command = plan

  variables {
    lifecycle_rules = [
      {
        action    = { type = "Delete" }
        condition = { age = 90 }
      },
      {
        action    = { type = "SetStorageClass", storage_class = "COLDLINE" }
        condition = { age = 30 }
      }
    ]
  }

  assert {
    condition     = length(google_storage_bucket.bucket.lifecycle_rule) == 2
    error_message = "expected 2 lifecycle rules"
  }
}

run "with_retention_policy" {
  command = plan

  variables {
    retention_policy = {
      retention_period = 86400
    }
  }

  assert {
    condition     = tonumber(google_storage_bucket.bucket.retention_policy[0].retention_period) == 86400
    error_message = "retention_period mismatch"
  }

  assert {
    condition     = google_storage_bucket.bucket.retention_policy[0].is_locked == false
    error_message = "default is_locked should be false"
  }
}

run "nearline_storage_class" {
  command = plan

  variables {
    storage_class = "NEARLINE"
  }

  assert {
    condition     = google_storage_bucket.bucket.storage_class == "NEARLINE"
    error_message = "storage_class should be NEARLINE"
  }
}

run "invalid_storage_class" {
  command = plan

  variables {
    storage_class = "INVALID"
  }

  expect_failures = [var.storage_class]
}
