# Live deployments.
# Each unit block declares a resource in an environment.

# --- Bootstrap (ops-admin-7x2) ---

unit "wif" {
  source = "../units/wif-github"
  path   = "bootstrap/wif-github"

  values = {
    github_org   = "Chopsticks13"
    repositories = ["Chopsticks13/gcp-foundation-modules"]
  }
}

# --- Dev environment ---

unit "dev_project" {
  source = "../units/project"
  path   = "dev/project"

  values = {
    environment     = "dev"
    project_id      = "ops-dev-7x2"
    project_name    = "Ops Dev"
    deletion_policy = "DELETE"
    team            = "platform"

    # Grant the CI/CD SA access to this project (no GCP Org = per-project grants)
    iam_additive = {
      "roles/browser"                          = ["serviceAccount:sa-ops-github-deploy@ops-admin-7x2.iam.gserviceaccount.com"]
      "roles/serviceusage.serviceUsageAdmin"   = ["serviceAccount:sa-ops-github-deploy@ops-admin-7x2.iam.gserviceaccount.com"]
      "roles/iam.serviceAccountAdmin"          = ["serviceAccount:sa-ops-github-deploy@ops-admin-7x2.iam.gserviceaccount.com"]
      "roles/storage.admin"                    = ["serviceAccount:sa-ops-github-deploy@ops-admin-7x2.iam.gserviceaccount.com"]
      "roles/resourcemanager.projectIamAdmin"  = ["serviceAccount:sa-ops-github-deploy@ops-admin-7x2.iam.gserviceaccount.com"]
    }
  }
}

unit "dev_service_account" {
  source = "../units/iam-service-account"
  path   = "dev/iam-service-account"

  values = {
    environment     = "dev"
    sa_name         = "sa-ops-dev-deploy"
    sa_display_name = "Ops Dev Deploy SA"
    sa_description  = "Service account for dev environment automation."
  }
}

unit "dev_bucket" {
  source = "../units/gcs"
  path   = "dev/gcs"

  values = {
    environment = "dev"
    bucket_name = "ops-dev-data-7x2"
    versioning  = true
  }
}
