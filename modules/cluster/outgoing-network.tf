locals {
  subnetwork_url = "https://www.googleapis.com/compute/v1/projects/${var.gcp_project}/regions/${var.gcp_region}/subnetworks/${google_compute_network.network.name}"
}

resource "google_compute_router" "gke-outgoing-router" {
  name = "${var.workspace_name}-gke-outgoing-router"
  network = google_compute_network.network.self_link
  region = var.gcp_region
}

resource "google_compute_address" "gke-outgoing-address" {
  count = 2

  name = "${var.workspace_name}-gke-outgoing-nat-address-${count.index}"
  region = var.gcp_region
}

resource "google_compute_router_nat" "gke-outgoing-nat" {
  name = "${var.workspace_name}-gke-outgoing-nat"
  router = google_compute_router.gke-outgoing-router.name
  region = var.gcp_region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = google_compute_address.gke-outgoing-address.*.self_link
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = local.subnetwork_url
    source_ip_ranges_to_nat = [ "ALL_IP_RANGES" ]
  }

  min_ports_per_vm = 16384
  log_config {
    enable = true
    filter = "ALL"
  }
}
