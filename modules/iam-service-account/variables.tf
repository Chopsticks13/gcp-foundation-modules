variable "description" {
  description = "Service account description."
  type        = string
  default     = "Managed by Terraform."
}

variable "display_name" {
  description = "Display name for the service account."
  type        = string
  default     = null
}

variable "iam" {
  description = "Authoritative IAM bindings ON this service account (who can impersonate it). Keys are roles, values are lists of members."
  type        = map(list(string))
  default     = {}
}

variable "iam_additive" {
  description = "Non-authoritative IAM bindings ON this service account."
  type        = map(list(string))
  default     = {}
}

variable "iam_project_roles" {
  description = "Project-level IAM roles granted TO this service account. Keys are project IDs, values are lists of roles."
  type        = map(list(string))
  default     = {}
}

variable "name" {
  description = "Service account ID (the part before @)."
  type        = string
}

variable "project_id" {
  description = "Project ID where the service account will be created."
  type        = string
}
