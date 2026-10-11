mock_provider "google" {}

variables {
  project_id = "test-project-01"
  name       = "test-vpc"
}

run "minimal_plan" {
  command = plan

  assert {
    condition     = google_compute_network.network.name == "test-vpc"
    error_message = "network name mismatch"
  }

  assert {
    condition     = google_compute_network.network.auto_create_subnetworks == false
    error_message = "auto_create_subnetworks should be disabled"
  }

  assert {
    condition     = google_compute_network.network.routing_mode == "GLOBAL"
    error_message = "default routing_mode should be GLOBAL"
  }

  assert {
    condition     = google_compute_network.network.description == "Managed by Terraform."
    error_message = "default description mismatch"
  }
}

run "with_subnets" {
  command = plan

  variables {
    subnets = [
      {
        name          = "subnet-dev"
        region        = "europe-west2"
        ip_cidr_range = "10.0.0.0/24"
      },
      {
        name          = "subnet-staging"
        region        = "europe-west2"
        ip_cidr_range = "10.0.1.0/24"
      }
    ]
  }

  assert {
    condition     = length(google_compute_subnetwork.subnets) == 2
    error_message = "expected 2 subnets"
  }

  assert {
    condition     = google_compute_subnetwork.subnets["subnet-dev"].ip_cidr_range == "10.0.0.0/24"
    error_message = "subnet-dev CIDR mismatch"
  }

  assert {
    condition     = google_compute_subnetwork.subnets["subnet-dev"].private_ip_google_access == true
    error_message = "private_google_access should default to true"
  }
}

run "with_secondary_ranges" {
  command = plan

  variables {
    subnets = [
      {
        name          = "subnet-gke"
        region        = "europe-west2"
        ip_cidr_range = "10.0.0.0/24"
        secondary_ranges = [
          { range_name = "pods", ip_cidr_range = "10.1.0.0/16" },
          { range_name = "services", ip_cidr_range = "10.2.0.0/20" }
        ]
      }
    ]
  }

  assert {
    condition     = length(google_compute_subnetwork.subnets["subnet-gke"].secondary_ip_range) == 2
    error_message = "expected 2 secondary ranges"
  }
}

run "with_nat" {
  command = plan

  variables {
    nat = {
      region = "europe-west2"
    }
  }

  assert {
    condition     = length(google_compute_router.router) == 1
    error_message = "expected 1 Cloud Router"
  }

  assert {
    condition     = length(google_compute_router_nat.nat) == 1
    error_message = "expected 1 Cloud NAT"
  }

  assert {
    condition     = google_compute_router_nat.nat[0].nat_ip_allocate_option == "AUTO_ONLY"
    error_message = "NAT should use AUTO_ONLY allocation"
  }

  assert {
    condition     = google_compute_router_nat.nat[0].source_subnetwork_ip_ranges_to_nat == "ALL_SUBNETWORKS_ALL_IP_RANGES"
    error_message = "NAT should cover all subnets"
  }
}

run "without_nat" {
  command = plan

  assert {
    condition     = length(google_compute_router.router) == 0
    error_message = "no router when NAT is disabled"
  }

  assert {
    condition     = length(google_compute_router_nat.nat) == 0
    error_message = "no NAT when NAT is disabled"
  }
}

run "regional_routing" {
  command = plan

  variables {
    routing_mode = "REGIONAL"
  }

  assert {
    condition     = google_compute_network.network.routing_mode == "REGIONAL"
    error_message = "routing_mode should be REGIONAL"
  }
}

run "invalid_routing_mode" {
  command = plan

  variables {
    routing_mode = "INVALID"
  }

  expect_failures = [var.routing_mode]
}

run "flow_logs_disabled" {
  command = plan

  variables {
    subnets = [
      {
        name          = "subnet-no-logs"
        region        = "europe-west2"
        ip_cidr_range = "10.0.0.0/24"
        flow_logs     = false
      }
    ]
  }

  assert {
    condition     = length(google_compute_subnetwork.subnets["subnet-no-logs"].log_config) == 0
    error_message = "log_config should be empty when flow_logs is false"
  }
}
