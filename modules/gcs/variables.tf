variable "encryption_key" {
  description = "CMEK key self-link for bucket encryption. Null uses Google-managed encryption."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Allow bucket deletion even if it contains objects."
  type        = bool
  default     = false
}

variable "iam" {
  description = "Authoritative IAM bindings. Keys are roles, values are lists of members."
  type        = map(list(string))
  default     = {}
}

variable "labels" {
  description = "Resource labels."
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "Bucket lifecycle rules."
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = object({
      age                   = optional(number)
      created_before        = optional(string)
      num_newer_versions    = optional(number)
      matches_storage_class = optional(list(string))
      with_state            = optional(string)
    })
  }))
  default = []
}

variable "location" {
  description = "Bucket location."
  type        = string
}

variable "name" {
  description = "Bucket name. Must be globally unique."
  type        = string
}

variable "project_id" {
  description = "Project ID."
  type        = string
}

variable "retention_policy" {
  description = "Retention policy. Null disables retention."
  type = object({
    retention_period = number
    is_locked        = optional(bool, false)
  })
  default = null
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE", "MULTI_REGIONAL", "REGIONAL"], var.storage_class)
    error_message = "Invalid storage class."
  }
}

variable "versioning" {
  description = "Enable object versioning."
  type        = bool
  default     = false
}
