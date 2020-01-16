resource "google_compute_network" "network" {
  name = "${var.workspace_name}-vpc"
  auto_create_subnetworks = "true"
}

resource "google_compute_global_address" "external-ip" {
  name = "${var.workspace_name}-backend-ip"
  address_type = "EXTERNAL"
}
