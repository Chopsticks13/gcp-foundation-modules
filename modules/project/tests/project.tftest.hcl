mock_provider "google" {}

variables {
  name       = "Test Project"
  project_id = "test-project-01"
}

run "minimal_plan" {
  command = plan

  assert {
    condition     = google_project.project.name == "Test Project"
    error_message = "project name mismatch"
  }

  assert {
    condition     = google_project.project.project_id == "test-project-01"
    error_message = "project_id mismatch"
  }

  assert {
    condition     = google_project.project.auto_create_network == false
    error_message = "auto_create_network should be disabled"
  }

  assert {
    condition     = google_project.project.deletion_policy == "PREVENT"
    error_message = "default deletion_policy should be PREVENT"
  }
}

run "with_parent_folder" {
  command = plan

  variables {
    parent = "folders/123456789"
  }

  assert {
    condition     = google_project.project.folder_id == "123456789"
    error_message = "folder_id should be extracted from parent"
  }

  assert {
    condition     = google_project.project.org_id == null
    error_message = "org_id should be null when parent is a folder"
  }
}

run "with_parent_org" {
  command = plan

  variables {
    parent = "organizations/987654321"
  }

  assert {
    condition     = google_project.project.org_id == "987654321"
    error_message = "org_id should be extracted from parent"
  }

  assert {
    condition     = google_project.project.folder_id == null
    error_message = "folder_id should be null when parent is an org"
  }
}

run "with_billing_and_labels" {
  command = plan

  variables {
    billing_account = "012345-6789AB-CDEF01"
    labels          = { environment = "dev", team = "platform" }
  }

  assert {
    condition     = google_project.project.billing_account == "012345-6789AB-CDEF01"
    error_message = "billing_account mismatch"
  }

  assert {
    condition     = google_project.project.labels["environment"] == "dev"
    error_message = "labels should include environment"
  }
}

run "with_services" {
  command = plan

  variables {
    services = ["compute.googleapis.com", "storage.googleapis.com"]
  }

  assert {
    condition     = length(google_project_service.services) == 2
    error_message = "expected 2 services to be enabled"
  }
}

run "deletion_policy_delete" {
  command = plan

  variables {
    deletion_policy = "DELETE"
  }

  assert {
    condition     = google_project.project.deletion_policy == "DELETE"
    error_message = "deletion_policy should be DELETE"
  }
}

run "invalid_project_id" {
  command = plan

  variables {
    project_id = "AB"
  }

  expect_failures = [var.project_id]
}

run "invalid_billing_format" {
  command = plan

  variables {
    billing_account = "not-valid"
  }

  expect_failures = [var.billing_account]
}

run "invalid_parent_format" {
  command = plan

  variables {
    parent = "invalid/format"
  }

  expect_failures = [var.parent]
}

run "invalid_deletion_policy" {
  command = plan

  variables {
    deletion_policy = "DESTROY"
  }

  expect_failures = [var.deletion_policy]
}
