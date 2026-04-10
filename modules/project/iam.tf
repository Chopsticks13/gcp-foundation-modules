locals {
  iam_additive_pairs = flatten([
    for role, members in var.iam_additive : [
      for member in members : {
        role   = role
        member = member
      }
    ]
  ])
}

# Authoritative IAM — owns the full member list for each role.
resource "google_project_iam_binding" "authoritative" {
  for_each = var.iam

  project = google_project.project.project_id
  role    = each.key
  members = each.value

  depends_on = [google_project_service.services]
}

# Additive IAM — adds members without removing existing ones.
resource "google_project_iam_member" "additive" {
  for_each = {
    for pair in local.iam_additive_pairs :
    "${pair.role}--${pair.member}" => pair
  }

  project = google_project.project.project_id
  role    = each.value.role
  member  = each.value.member

  depends_on = [google_project_service.services]
}
