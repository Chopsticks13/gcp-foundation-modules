# Live deployments.
# Each unit block declares a resource in an environment.

unit "dev_project" {
  source = "../units/project"
  path   = "dev/project"

  values = {
    environment     = "dev"
    project_id      = "ops-dev-7x2"
    project_name    = "Ops Dev"
    deletion_policy = "DELETE"
    team            = "platform"
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
