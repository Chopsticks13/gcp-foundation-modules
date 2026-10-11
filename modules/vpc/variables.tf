variable "project_id" {
  description = "Project ID."
  type        = string
}

variable "name" {
  description = "VPC network name."
  type        = string
}

variable "description" {
  description = "Network description."
  type        = string
  default     = "Managed by Terraform."
}

variable "routing_mode" {
  description = "Network routing mode."
  type        = string
  default     = "GLOBAL"

  validation {
    condition     = contains(["GLOBAL", "REGIONAL"], var.routing_mode)
    error_message = "routing_mode must be GLOBAL or REGIONAL."
  }
}

variable "delete_default_routes" {
  description = "Delete default internet gateway routes on creation."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "Subnets to create in the VPC."
  type = list(object({
    name                  = string
    region                = string
    ip_cidr_range         = string
    private_google_access = optional(bool, true)
    flow_logs             = optional(bool, true)
    secondary_ranges = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })), [])
  }))
  default = []
}

variable "nat" {
  description = "Cloud NAT configuration. Null disables NAT."
  type = object({
    name   = optional(string, "cloud-nat")
    region = string
  })
  default = null
}

variable "mtu" {
  description = "Network MTU. 0 uses the default (1460)."
  type        = number
  default     = 0
}
