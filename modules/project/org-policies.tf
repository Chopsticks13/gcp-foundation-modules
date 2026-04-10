resource "google_org_policy_policy" "policies" {
  for_each = var.org_policies

  name   = "projects/${google_project.project.project_id}/policies/${each.key}"
  parent = "projects/${google_project.project.project_id}"

  spec {
    dynamic "rules" {
      for_each = each.value.enforce != null ? [each.value.enforce] : []
      content {
        enforce = rules.value ? "TRUE" : "FALSE"
      }
    }

    dynamic "rules" {
      for_each = each.value.rules
      content {
        dynamic "allow" {
          for_each = rules.value.allow != null ? [rules.value.allow] : []
          content {
            all    = allow.value.all
            values = allow.value.values
          }
        }
        dynamic "deny" {
          for_each = rules.value.deny != null ? [rules.value.deny] : []
          content {
            all    = deny.value.all
            values = deny.value.values
          }
        }
        enforce = rules.value.enforce != null ? (rules.value.enforce ? "TRUE" : "FALSE") : null
        dynamic "condition" {
          for_each = rules.value.condition != null ? [rules.value.condition] : []
          content {
            description = condition.value.description
            expression  = condition.value.expression
            title       = condition.value.title
          }
        }
      }
    }
  }
}
