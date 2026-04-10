variable "github_org" {
  description = "GitHub organisation or username that is allowed to authenticate."
  type        = string
}

variable "pool_id" {
  description = "Workload Identity Pool ID."
  type        = string
  default     = "github"
}

variable "project_id" {
  description = "Project ID where the WIF pool and SA will be created."
  type        = string
}

variable "provider_id" {
  description = "Workload Identity Provider ID."
  type        = string
  default     = "foundation"
}

variable "repositories" {
  description = "List of GitHub repositories allowed to authenticate (format: owner/repo)."
  type        = list(string)
}

variable "sa_id" {
  description = "Service account ID to create for GitHub Actions."
  type        = string
  default     = "sa-ops-github-deploy"
}

variable "sa_project_roles" {
  description = "IAM roles to grant the SA on the project."
  type        = list(string)
  default = [
    "roles/serviceusage.serviceUsageAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/storage.admin",
    "roles/resourcemanager.projectCreator",
    "roles/billing.user",
  ]
}
