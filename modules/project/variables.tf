variable "billing_account" {
  description = "Billing account ID."
  type        = string
  default     = null

  validation {
    condition     = var.billing_account == null || can(regex("^[A-Z0-9]{6}-[A-Z0-9]{6}-[A-Z0-9]{6}$", var.billing_account))
    error_message = "Billing account must be in format '012345-6789AB-CDEF01'."
  }
}

variable "deletion_policy" {
  description = "Deletion policy for the project. 'PREVENT' protects against accidental deletion."
  type        = string
  default     = "PREVENT"

  validation {
    condition     = contains(["DELETE", "PREVENT"], var.deletion_policy)
    error_message = "Deletion policy must be 'DELETE' or 'PREVENT'."
  }
}

variable "iam" {
  description = "Authoritative IAM bindings. Keys are roles, values are lists of members."
  type        = map(list(string))
  default     = {}
}

variable "iam_additive" {
  description = "Non-authoritative IAM bindings. Keys are roles, values are lists of members."
  type        = map(list(string))
  default     = {}
}

variable "labels" {
  description = "Resource labels."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Project display name."
  type        = string
}

variable "org_policies" {
  description = "Organisation policy overrides at project level."
  type = map(object({
    enforce = optional(bool)
    rules = optional(list(object({
      allow = optional(object({
        all    = optional(bool)
        values = optional(list(string))
      }))
      deny = optional(object({
        all    = optional(bool)
        values = optional(list(string))
      }))
      enforce = optional(bool)
      condition = optional(object({
        description = optional(string)
        expression  = string
        title       = string
      }))
    })), [])
  }))
  default = {}
}

variable "parent" {
  description = "Parent in 'folders/ID' or 'organizations/ID' format. Null for standalone projects."
  type        = string
  default     = null

  validation {
    condition     = var.parent == null || can(regex("^(folders|organizations)/[0-9]+$", var.parent))
    error_message = "Parent must be null or in 'folders/123' or 'organizations/123' format."
  }
}

variable "project_id" {
  description = "Project ID. Globally unique, 6-30 characters, lowercase letters, digits, hyphens."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be 6-30 chars, start with a letter, lowercase only."
  }
}

variable "services" {
  description = "GCP APIs to enable on the project."
  type        = list(string)
  default     = []
}

variable "shared_vpc_host" {
  description = "Enable this project as a Shared VPC host."
  type        = bool
  default     = false
}

variable "shared_vpc_service" {
  description = "Shared VPC host project ID to attach this project to as a service project."
  type        = string
  default     = null
}
