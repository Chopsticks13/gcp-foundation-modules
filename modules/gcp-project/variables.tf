/**
 * Input Variables
 */

# Required variables
variable "project_name" {
  description = "Human-readable project name"
  type        = string
}

variable "project_id" {
  description = "Unique project ID (6-30 chars, lowercase, numbers, hyphens)"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be 6-30 chars, start with letter, lowercase only."
  }
}

variable "folder_id" {
  description = "Folder ID where project will be created (optional, null for non-org accounts)"
  type        = string
  default     = null

  validation {
    condition     = var.folder_id == null || can(regex("^folders/[0-9]+$", var.folder_id))
    error_message = "Folder ID must be null or in format 'folders/123456789'."
  }
}

variable "billing_account" {
  description = "Billing account ID"
  type        = string

  validation {
    condition     = can(regex("^[A-Z0-9]{6}-[A-Z0-9]{6}-[A-Z0-9]{6}$", var.billing_account))
    error_message = "Billing account must be in format '012345-6789AB-CDEF01'."
  }
}

variable "organization_id" {
  description = "Organization ID (not used without an org)"
  type        = string
  default     = null
}


# Metadata
variable "environment" {
  description = "Environment (dev, staging, prod, sandbox)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod", "sandbox"], var.environment)
    error_message = "Environment must be: dev, staging, prod, or sandbox."
  }
}

variable "team" {
  description = "Team owning this project"
  type        = string
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}

# API enablement
variable "enable_compute" {
  description = "Enable Compute Engine API"
  type        = bool
  default     = false
}

variable "enable_gke" {
  description = "Enable GKE API"
  type        = bool
  default     = false
}

variable "enable_cloud_run" {
  description = "Enable Cloud Run API"
  type        = bool
  default     = false
}

variable "enable_cloud_sql" {
  description = "Enable Cloud SQL API"
  type        = bool
  default     = false
}

variable "enable_secret_manager" {
  description = "Enable Secret Manager API"
  type        = bool
  default     = true
}

variable "enable_kms" {
  description = "Enable KMS API"
  type        = bool
  default     = false
}

variable "enable_logging" {
  description = "Enable Cloud Logging API"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Enable Cloud Monitoring API"
  type        = bool
  default     = true
}

variable "additional_apis" {
  description = "Additional APIs to enable"
  type        = list(string)
  default     = []
}

# IAM
variable "iam_bindings" {
  description = "IAM bindings (role => member)"
  type        = map(string)
  default     = {}
}

variable "service_accounts" {
  description = "Service accounts to create"
  type = map(object({
    display_name = string
    description  = optional(string)
    roles        = optional(list(string), [])
  }))
  default = {}
}

variable "workload_identity_bindings" {
  description = "Workload Identity bindings (GKE to GSA)"
  type = map(object({
    service_account = string
    namespace       = string
    ksa             = string # Kubernetes Service Account
  }))
  default = {}
}

# Organization policies
variable "enable_default_policies" {
  description = "Enable default security policies"
  type        = bool
  default     = true
}

variable "org_policies" {
  description = "Custom organization policies"
  type = map(object({
    enforce = optional(bool)
    allow = optional(object({
      all    = optional(bool)
      values = optional(list(string))
    }))
    deny = optional(object({
      all    = optional(bool)
      values = optional(list(string))
    }))
    deny_all            = optional(bool)
    inherit_from_parent = optional(bool)
  }))
  default = {}
}