mock_provider "google" {}

variables {
  name       = "sa-test"
  project_id = "test-project-01"
}

run "minimal_plan" {
  command = plan

  assert {
    condition     = google_service_account.sa.account_id == "sa-test"
    error_message = "account_id mismatch"
  }

  assert {
    condition     = google_service_account.sa.project == "test-project-01"
    error_message = "project mismatch"
  }

  assert {
    condition     = google_service_account.sa.display_name == "sa-test"
    error_message = "display_name should default to name"
  }

  assert {
    condition     = google_service_account.sa.description == "Managed by Terraform."
    error_message = "default description mismatch"
  }
}

run "with_display_name" {
  command = plan

  variables {
    display_name = "My Test SA"
  }

  assert {
    condition     = google_service_account.sa.display_name == "My Test SA"
    error_message = "display_name should use provided value"
  }
}

run "with_iam_bindings" {
  command = plan

  variables {
    iam = {
      "roles/iam.serviceAccountTokenCreator" = ["user:admin@example.com"]
    }
  }

  assert {
    condition     = length(google_service_account_iam_binding.authoritative) == 1
    error_message = "expected 1 authoritative IAM binding"
  }
}

run "with_project_roles" {
  command = plan

  variables {
    iam_project_roles = {
      "test-project-01" = ["roles/storage.admin", "roles/compute.viewer"]
    }
  }

  assert {
    condition     = length(google_project_iam_member.project_roles) == 2
    error_message = "expected 2 project role bindings"
  }
}
