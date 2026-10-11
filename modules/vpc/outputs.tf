output "network_id" {
  description = "VPC network ID."
  value       = google_compute_network.network.id
}

output "network_name" {
  description = "VPC network name."
  value       = google_compute_network.network.name
}

output "network_self_link" {
  description = "VPC network self link."
  value       = google_compute_network.network.self_link
}

output "subnets" {
  description = "Map of subnet objects keyed by name."
  value       = google_compute_subnetwork.subnets
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by name."
  value       = { for k, v in google_compute_subnetwork.subnets : k => v.id }
}

output "subnet_self_links" {
  description = "Map of subnet self links keyed by name."
  value       = { for k, v in google_compute_subnetwork.subnets : k => v.self_link }
}

output "router_id" {
  description = "Cloud Router ID. Null if NAT is disabled."
  value       = try(google_compute_router.router[0].id, null)
}

output "nat_id" {
  description = "Cloud NAT ID. Null if NAT is disabled."
  value       = try(google_compute_router_nat.nat[0].id, null)
}
