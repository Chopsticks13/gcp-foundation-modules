mock_provider "google" {}

variables {
  project_id   = "test-project-01"
  github_org   = "Chopsticks13"
  repositories = ["Chopsticks13/gcp-foundation-modules"]
}

run "minimal_plan" {
  command = plan

  assert {
    condition     = google_iam_workload_identity_pool.pool.workload_identity_pool_id == "github"
    error_message = "default pool_id should be github"
  }

  assert {
    condition     = google_iam_workload_identity_pool_provider.provider.workload_identity_pool_provider_id == "foundation"
    error_message = "default provider_id should be foundation"
  }

  assert {
    condition     = google_service_account.deploy.account_id == "sa-ops-github-deploy"
    error_message = "default sa_id mismatch"
  }

  assert {
    condition     = google_service_account.deploy.project == "test-project-01"
    error_message = "project mismatch"
  }
}

run "oidc_config" {
  command = plan

  assert {
    condition     = google_iam_workload_identity_pool_provider.provider.oidc[0].issuer_uri == "https://token.actions.githubusercontent.com"
    error_message = "OIDC issuer should be GitHub Actions"
  }

  assert {
    condition     = google_iam_workload_identity_pool_provider.provider.attribute_condition == "assertion.repository_owner == 'Chopsticks13'"
    error_message = "attribute_condition should scope to github_org"
  }
}

run "per_repo_bindings" {
  command = plan

  variables {
    repositories = [
      "Chopsticks13/gcp-foundation-modules",
      "Chopsticks13/another-repo",
    ]
  }

  assert {
    condition     = length(google_service_account_iam_member.wif_binding) == 2
    error_message = "expected one WIF binding per repository"
  }
}

run "custom_ids" {
  command = plan

  variables {
    pool_id     = "custom-pool"
    provider_id = "custom-provider"
    sa_id       = "sa-custom-deploy"
  }

  assert {
    condition     = google_iam_workload_identity_pool.pool.workload_identity_pool_id == "custom-pool"
    error_message = "pool_id should use custom value"
  }

  assert {
    condition     = google_iam_workload_identity_pool_provider.provider.workload_identity_pool_provider_id == "custom-provider"
    error_message = "provider_id should use custom value"
  }

  assert {
    condition     = google_service_account.deploy.account_id == "sa-custom-deploy"
    error_message = "sa_id should use custom value"
  }
}

run "sa_role_count" {
  command = plan

  assert {
    condition     = length(google_project_iam_member.sa_roles) == 6
    error_message = "default sa_project_roles should grant 6 roles"
  }
}
