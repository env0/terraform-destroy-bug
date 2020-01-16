locals {
  cluster_name = "${var.workspace_name}-cluster"
  cluster_master_cidr = "172.16.0.0/28"
}

data "google_container_engine_versions" "valid_gke_versions" {
  version_prefix = var.master_gke_version_prefix
  location = var.gcp_zone
}

resource "random_string" "cluster_password" {
  length = 50
}

resource "google_container_cluster" "cluster" {
  name = local.cluster_name
  resource_labels = {
    workspace = var.workspace_name
  }
  network = google_compute_network.network.self_link
  remove_default_node_pool = true

  min_master_version = data.google_container_engine_versions.valid_gke_versions.latest_master_version

  location = var.gcp_zone

  initial_node_count = 1

  node_locations = var.cluster_zones

  ip_allocation_policy {}

  master_auth {
    username = var.username
    password = random_string.cluster_password.result
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = local.cluster_master_cidr
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
      display_name = "allow-all"
    }
  }
  lifecycle {
    // prevent updates to master version when configuration is re-applied on an existing workspace
    ignore_changes = [ min_master_version ]
  }
}

locals {
  gke_required_oauth_scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
  ]
  gcr_access_oath_scopes = ["https://www.googleapis.com/auth/devstorage.read_only"]
  all_oauth_scopes = concat(local.gke_required_oauth_scopes, local.gcr_access_oath_scopes)
}

resource "google_container_node_pool" "node_pool" {
  name = "${var.workspace_name}-node-pool"
  cluster = google_container_cluster.cluster.name
  version = var.node_gke_version
  location = ""
  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair = true
    auto_upgrade = false
  }

  node_config {
    labels = {
      workspace = var.workspace_name
    }
    machine_type = "n1-highcpu-8"
    min_cpu_platform = "Intel Haswell"

    oauth_scopes = local.all_oauth_scopes
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
