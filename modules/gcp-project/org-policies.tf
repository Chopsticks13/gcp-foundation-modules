/**
 * Organization Policies
 * Note: Without an organization, some policies may not be available
 * These are applied at the project level
 */

locals {
  # Simplified policies for non-org accounts
  default_policies = var.enable_default_policies ? {
    # This one works at project level
    "compute.skipDefaultNetworkCreation" = {
      enforce = true
    }

    # These work at project level
    "compute.requireOsLogin" = {
      enforce = true
    }

    "storage.uniformBucketLevelAccess" = {
      enforce = true
    }
  } : {}

  all_policies = merge(local.default_policies, var.org_policies)
}

# Note: Some org policies require an organization
# They will fail gracefully if not applicable
resource "google_project_organization_policy" "policies" {
  for_each = local.all_policies

  project    = google_project.project.project_id
  constraint = each.key

  dynamic "boolean_policy" {
    for_each = can(each.value.enforce) ? [1] : []
    content {
      enforced = each.value.enforce
    }
  }

  dynamic "list_policy" {
    for_each = can(each.value.allow) || can(each.value.deny) || can(each.value.deny_all) ? [1] : []
    content {
      inherit_from_parent = try(each.value.inherit_from_parent, false)

      dynamic "allow" {
        for_each = can(each.value.allow) ? [1] : []
        content {
          all    = try(each.value.allow.all, false)
          values = try(each.value.allow.values, null)
        }
      }

      dynamic "deny" {
        for_each = can(each.value.deny) || can(each.value.deny_all) ? [1] : []
        content {
          all    = try(each.value.deny_all, false)
          values = try(each.value.deny.values, null)
        }
      }
    }
  }

  depends_on = [google_project.project]
}