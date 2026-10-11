resource "google_compute_network" "network" {
  project                 = var.project_id
  name                    = var.name
  description             = var.description
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode
  mtu                     = var.mtu > 0 ? var.mtu : null

  delete_default_routes_on_create = var.delete_default_routes
}

resource "google_compute_subnetwork" "subnets" {
  for_each = { for s in var.subnets : s.name => s }

  project                  = var.project_id
  network                  = google_compute_network.network.id
  name                     = each.value.name
  region                   = each.value.region
  ip_cidr_range            = each.value.ip_cidr_range
  private_ip_google_access = each.value.private_google_access

  dynamic "log_config" {
    for_each = each.value.flow_logs ? [1] : []
    content {
      aggregation_interval = "INTERVAL_5_SEC"
      flow_sampling        = 0.5
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}

resource "google_compute_router" "router" {
  count = var.nat != null ? 1 : 0

  project = var.project_id
  name    = "${var.name}-router"
  network = google_compute_network.network.id
  region  = var.nat.region
}

resource "google_compute_router_nat" "nat" {
  count = var.nat != null ? 1 : 0

  project = var.project_id
  name    = var.nat.name
  router  = google_compute_router.router[0].name
  region  = var.nat.region

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
