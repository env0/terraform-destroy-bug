output "name" {
  value = local.cluster_name
}

output "host" {
  value = google_container_cluster.cluster.endpoint
  sensitive = true
}

output "cluster_ca_certificate" {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}

output "external_ip_name" {
  value = google_compute_global_address.external-ip.name
}

output "password" {
  value = google_container_cluster.cluster.master_auth[0].password
}

output "network" {
  value = google_compute_network.network.self_link
}
