## Terraform fails to `apply` a `plan` to `-destroy` but able to `terraform destroy`
This repository is meant to recreate a potential bug in Terraform (tested in both 0.12.18 and 0.12.19).  

## Steps to reproduce
1. Place a `credentials.json` with your google account.
2. Create a project in your google account `env0project` (or set your project as `var.gcp_project`)
3. `➜ terraform init`
    <details><summary>(output)</summary>
    <p>
      
      ```      
    Initializing modules...
    - cluster in modules/cluster
    - kubernetes in modules/kubernetes

    Initializing the backend...

    Initializing provider plugins...
    - Checking for available provider plugins...
    - Downloading plugin for provider "google" (hashicorp/google) 3.3.0...
    - Downloading plugin for provider "google-beta" (terraform-providers/google-beta) 3.3.0...
    - Downloading plugin for provider "kubernetes" (hashicorp/kubernetes) 1.9.0...
    - Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
    - Downloading plugin for provider "random" (hashicorp/random) 2.2.1...
    - Downloading plugin for provider "external" (hashicorp/external) 1.2.0...
    - Downloading plugin for provider "tls" (hashicorp/tls) 2.1.1...

    Terraform has been successfully initialized!
      
      ```
      
  </p>
  </details>
  
4. `➜ terraform apply`

    <details><summary>(output)</summary>
    <p>
      
      ```      
    module.cluster.data.google_container_engine_versions.valid_gke_versions: Refreshing state...

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # module.cluster.google_compute_address.gke-outgoing-address[0] will be created
    + resource "google_compute_address" "gke-outgoing-address" {
        + address            = (known after apply)
        + address_type       = "EXTERNAL"
        + creation_timestamp = (known after apply)
        + id                 = (known after apply)
        + name               = "default-gke-outgoing-nat-address-0"
        + network_tier       = (known after apply)
        + project            = (known after apply)
        + purpose            = (known after apply)
        + region             = "us-east1"
        + self_link          = (known after apply)
        + subnetwork         = (known after apply)
        + users              = (known after apply)
        }

    # module.cluster.google_compute_address.gke-outgoing-address[1] will be created
    + resource "google_compute_address" "gke-outgoing-address" {
        + address            = (known after apply)
        + address_type       = "EXTERNAL"
        + creation_timestamp = (known after apply)
        + id                 = (known after apply)
        + name               = "default-gke-outgoing-nat-address-1"
        + network_tier       = (known after apply)
        + project            = (known after apply)
        + purpose            = (known after apply)
        + region             = "us-east1"
        + self_link          = (known after apply)
        + subnetwork         = (known after apply)
        + users              = (known after apply)
        }

    # module.cluster.google_compute_global_address.external-ip will be created
    + resource "google_compute_global_address" "external-ip" {
        + address            = (known after apply)
        + creation_timestamp = (known after apply)
        + id                 = (known after apply)
        + name               = "default-backend-ip"
        + project            = (known after apply)
        + self_link          = (known after apply)
        }

    # module.cluster.google_compute_network.network will be created
    + resource "google_compute_network" "network" {
        + auto_create_subnetworks         = true
        + delete_default_routes_on_create = false
        + gateway_ipv4                    = (known after apply)
        + id                              = (known after apply)
        + ipv4_range                      = (known after apply)
        + name                            = "default-vpc"
        + project                         = (known after apply)
        + routing_mode                    = (known after apply)
        + self_link                       = (known after apply)
        }

    # module.cluster.google_compute_router.gke-outgoing-router will be created
    + resource "google_compute_router" "gke-outgoing-router" {
        + creation_timestamp = (known after apply)
        + id                 = (known after apply)
        + name               = "default-gke-outgoing-router"
        + network            = (known after apply)
        + project            = (known after apply)
        + region             = "us-east1"
        + self_link          = (known after apply)
        }

    # module.cluster.google_compute_router_nat.gke-outgoing-nat will be created
    + resource "google_compute_router_nat" "gke-outgoing-nat" {
        + icmp_idle_timeout_sec              = 30
        + id                                 = (known after apply)
        + min_ports_per_vm                   = 16384
        + name                               = "default-gke-outgoing-nat"
        + nat_ip_allocate_option             = "MANUAL_ONLY"
        + nat_ips                            = (known after apply)
        + project                            = (known after apply)
        + region                             = "us-east1"
        + router                             = "default-gke-outgoing-router"
        + source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
        + tcp_established_idle_timeout_sec   = 1200
        + tcp_transitory_idle_timeout_sec    = 30
        + udp_idle_timeout_sec               = 30

        + log_config {
            + enable = true
            + filter = "ALL"
            }

        + subnetwork {
            + name                     = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/subnetworks/default-vpc"
            + secondary_ip_range_names = []
            + source_ip_ranges_to_nat  = [
                + "ALL_IP_RANGES",
                ]
            }
        }

    # module.cluster.google_container_cluster.cluster will be created
    + resource "google_container_cluster" "cluster" {
        + cluster_ipv4_cidr           = (known after apply)
        + default_max_pods_per_node   = (known after apply)
        + enable_binary_authorization = (known after apply)
        + enable_kubernetes_alpha     = false
        + enable_legacy_abac          = false
        + enable_tpu                  = (known after apply)
        + endpoint                    = (known after apply)
        + id                          = (known after apply)
        + initial_node_count          = 1
        + instance_group_urls         = (known after apply)
        + location                    = "us-east1-b"
        + logging_service             = "logging.googleapis.com/kubernetes"
        + master_version              = (known after apply)
        + min_master_version          = "1.14.10-gke.0"
        + monitoring_service          = "monitoring.googleapis.com/kubernetes"
        + name                        = "default-cluster"
        + network                     = (known after apply)
        + node_locations              = (known after apply)
        + node_version                = (known after apply)
        + project                     = (known after apply)
        + remove_default_node_pool    = true
        + resource_labels             = {
            + "workspace" = "default"
            }
        + services_ipv4_cidr          = (known after apply)
        + subnetwork                  = (known after apply)

        + addons_config {
            + horizontal_pod_autoscaling {
                + disabled = (known after apply)
                }

            + http_load_balancing {
                + disabled = (known after apply)
                }

            + kubernetes_dashboard {
                + disabled = (known after apply)
                }

            + network_policy_config {
                + disabled = (known after apply)
                }
            }

        + authenticator_groups_config {
            + security_group = (known after apply)
            }

        + cluster_autoscaling {
            + enabled = (known after apply)

            + auto_provisioning_defaults {
                + oauth_scopes    = (known after apply)
                + service_account = (known after apply)
                }

            + resource_limits {
                + maximum       = (known after apply)
                + minimum       = (known after apply)
                + resource_type = (known after apply)
                }
            }

        + ip_allocation_policy {
            + cluster_ipv4_cidr_block       = (known after apply)
            + cluster_secondary_range_name  = (known after apply)
            + create_subnetwork             = (known after apply)
            + node_ipv4_cidr_block          = (known after apply)
            + services_ipv4_cidr_block      = (known after apply)
            + services_secondary_range_name = (known after apply)
            + subnetwork_name               = (known after apply)
            + use_ip_aliases                = (known after apply)
            }

        + master_auth {
            + client_certificate     = (known after apply)
            + client_key             = (sensitive value)
            + cluster_ca_certificate = (known after apply)
            + password               = (sensitive value)
            + username               = "admin"

            + client_certificate_config {
                + issue_client_certificate = false
                }
            }

        + master_authorized_networks_config {
            + cidr_blocks {
                + cidr_block   = "0.0.0.0/0"
                + display_name = "allow-all"
                }
            }

        + network_policy {
            + enabled  = (known after apply)
            + provider = (known after apply)
            }

        + node_config {
            + disk_size_gb      = (known after apply)
            + disk_type         = (known after apply)
            + guest_accelerator = (known after apply)
            + image_type        = (known after apply)
            + labels            = (known after apply)
            + local_ssd_count   = (known after apply)
            + machine_type      = (known after apply)
            + metadata          = (known after apply)
            + min_cpu_platform  = (known after apply)
            + oauth_scopes      = (known after apply)
            + preemptible       = (known after apply)
            + service_account   = (known after apply)
            + tags              = (known after apply)
            + taint             = (known after apply)

            + sandbox_config {
                + sandbox_type = (known after apply)
                }

            + shielded_instance_config {
                + enable_integrity_monitoring = (known after apply)
                + enable_secure_boot          = (known after apply)
                }

            + workload_metadata_config {
                + node_metadata = (known after apply)
                }
            }

        + node_pool {
            + initial_node_count  = (known after apply)
            + instance_group_urls = (known after apply)
            + max_pods_per_node   = (known after apply)
            + name                = (known after apply)
            + name_prefix         = (known after apply)
            + node_count          = (known after apply)
            + version             = (known after apply)

            + autoscaling {
                + max_node_count = (known after apply)
                + min_node_count = (known after apply)
                }

            + management {
                + auto_repair  = (known after apply)
                + auto_upgrade = (known after apply)
                }

            + node_config {
                + disk_size_gb      = (known after apply)
                + disk_type         = (known after apply)
                + guest_accelerator = (known after apply)
                + image_type        = (known after apply)
                + labels            = (known after apply)
                + local_ssd_count   = (known after apply)
                + machine_type      = (known after apply)
                + metadata          = (known after apply)
                + min_cpu_platform  = (known after apply)
                + oauth_scopes      = (known after apply)
                + preemptible       = (known after apply)
                + service_account   = (known after apply)
                + tags              = (known after apply)
                + taint             = (known after apply)

                + sandbox_config {
                    + sandbox_type = (known after apply)
                    }

                + shielded_instance_config {
                    + enable_integrity_monitoring = (known after apply)
                    + enable_secure_boot          = (known after apply)
                    }

                + workload_metadata_config {
                    + node_metadata = (known after apply)
                    }
                }
            }

        + private_cluster_config {
            + enable_private_nodes   = true
            + master_ipv4_cidr_block = "172.16.0.0/28"
            + private_endpoint       = (known after apply)
            + public_endpoint        = (known after apply)
            }
        }

    # module.cluster.google_container_node_pool.node_pool will be created
    + resource "google_container_node_pool" "node_pool" {
        + cluster             = "default-cluster"
        + id                  = (known after apply)
        + initial_node_count  = 1
        + instance_group_urls = (known after apply)
        + location            = (known after apply)
        + max_pods_per_node   = (known after apply)
        + name                = "default-node-pool"
        + name_prefix         = (known after apply)
        + node_count          = (known after apply)
        + project             = (known after apply)
        + version             = "1.14.7-gke.10"

        + autoscaling {
            + max_node_count = 2
            + min_node_count = 1
            }

        + management {
            + auto_repair  = true
            + auto_upgrade = false
            }

        + node_config {
            + disk_size_gb      = (known after apply)
            + disk_type         = (known after apply)
            + guest_accelerator = (known after apply)
            + image_type        = (known after apply)
            + labels            = {
                + "workspace" = "default"
                }
            + local_ssd_count   = (known after apply)
            + machine_type      = "n1-highcpu-8"
            + metadata          = {
                + "disable-legacy-endpoints" = "true"
                }
            + min_cpu_platform  = "Intel Haswell"
            + oauth_scopes      = [
                + "https://www.googleapis.com/auth/compute",
                + "https://www.googleapis.com/auth/devstorage.read_only",
                + "https://www.googleapis.com/auth/logging.write",
                + "https://www.googleapis.com/auth/monitoring",
                ]
            + preemptible       = false
            + service_account   = (known after apply)
            + taint             = (known after apply)

            + shielded_instance_config {
                + enable_integrity_monitoring = (known after apply)
                + enable_secure_boot          = (known after apply)
                }
            }
        }

    # module.cluster.random_string.cluster_password will be created
    + resource "random_string" "cluster_password" {
        + id          = (known after apply)
        + length      = 50
        + lower       = true
        + min_lower   = 0
        + min_numeric = 0
        + min_special = 0
        + min_upper   = 0
        + number      = true
        + result      = (known after apply)
        + special     = true
        + upper       = true
        }

    # module.kubernetes.kubernetes_storage_class.ssd will be created
    + resource "kubernetes_storage_class" "ssd" {
        + allow_volume_expansion = true
        + id                     = (known after apply)
        + parameters             = {
            + "type" = "pd-ssd"
            }
        + reclaim_policy         = "Delete"
        + storage_provisioner    = "kubernetes.io/gce-pd"
        + volume_binding_mode    = "Immediate"

        + metadata {
            + generation       = (known after apply)
            + name             = "ssd"
            + resource_version = (known after apply)
            + self_link        = (known after apply)
            + uid              = (known after apply)
            }
        }

    Plan: 10 to add, 0 to change, 0 to destroy.

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes
      
      ```
      
  </p>
  </details>
  
5. `➜ terraform plan -destroy -out=destroy.tf-plan`

    <details><summary>(output)</summary>
    <p>
      
      ```              
    Refreshing Terraform state in-memory prior to plan...
    The refreshed state will be used to calculate this plan, but will not be
    persisted to local or remote state storage.

    module.cluster.random_string.cluster_password: Refreshing state... [id=YJww(=l+yo)-F0BW-(cF{I(-(##MmU8N*U3$zk_f_HCA01}G3?]
    module.cluster.google_compute_global_address.external-ip: Refreshing state... [id=projects/env0project/global/addresses/default-backend-ip]
    module.cluster.google_compute_network.network: Refreshing state... [id=projects/env0project/global/networks/default-vpc]
    module.cluster.data.google_container_engine_versions.valid_gke_versions: Refreshing state...
    module.cluster.google_compute_address.gke-outgoing-address[1]: Refreshing state... [id=projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1]
    module.cluster.google_compute_address.gke-outgoing-address[0]: Refreshing state... [id=projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0]
    module.cluster.google_compute_router.gke-outgoing-router: Refreshing state... [id=projects/env0project/regions/us-east1/routers/default-gke-outgoing-router]
    module.cluster.google_container_cluster.cluster: Refreshing state... [id=projects/env0project/locations/us-east1-b/clusters/default-cluster]
    module.cluster.google_compute_router_nat.gke-outgoing-nat: Refreshing state... [id=env0project/us-east1/default-gke-outgoing-router/default-gke-outgoing-nat]
    module.cluster.google_container_node_pool.node_pool: Refreshing state... [id=projects/env0project/locations/us-east1-b/clusters/default-cluster/nodePools/default-node-pool]
    module.kubernetes.kubernetes_storage_class.ssd: Refreshing state... [id=ssd]

    ------------------------------------------------------------------------

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
    - destroy

    Terraform will perform the following actions:

    # module.cluster.google_compute_address.gke-outgoing-address[0] will be destroyed
    - resource "google_compute_address" "gke-outgoing-address" {
        - address            = "35.231.97.206" -> null
        - address_type       = "EXTERNAL" -> null
        - creation_timestamp = "2020-01-16T08:11:18.565-08:00" -> null
        - id                 = "projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0" -> null
        - name               = "default-gke-outgoing-nat-address-0" -> null
        - network_tier       = "PREMIUM" -> null
        - project            = "env0project" -> null
        - region             = "us-east1" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0" -> null
        - users              = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/routers/default-gke-outgoing-router",
            ] -> null
        }

    # module.cluster.google_compute_address.gke-outgoing-address[1] will be destroyed
    - resource "google_compute_address" "gke-outgoing-address" {
        - address            = "35.237.142.252" -> null
        - address_type       = "EXTERNAL" -> null
        - creation_timestamp = "2020-01-16T08:11:18.685-08:00" -> null
        - id                 = "projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1" -> null
        - name               = "default-gke-outgoing-nat-address-1" -> null
        - network_tier       = "PREMIUM" -> null
        - project            = "env0project" -> null
        - region             = "us-east1" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1" -> null
        - users              = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/routers/default-gke-outgoing-router",
            ] -> null
        }

    # module.cluster.google_compute_global_address.external-ip will be destroyed
    - resource "google_compute_global_address" "external-ip" {
        - address            = "34.107.146.15" -> null
        - address_type       = "EXTERNAL" -> null
        - creation_timestamp = "2020-01-16T08:11:18.515-08:00" -> null
        - id                 = "projects/env0project/global/addresses/default-backend-ip" -> null
        - name               = "default-backend-ip" -> null
        - prefix_length      = 0 -> null
        - project            = "env0project" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/global/addresses/default-backend-ip" -> null
        }

    # module.cluster.google_compute_network.network will be destroyed
    - resource "google_compute_network" "network" {
        - auto_create_subnetworks         = true -> null
        - delete_default_routes_on_create = false -> null
        - id                              = "projects/env0project/global/networks/default-vpc" -> null
        - name                            = "default-vpc" -> null
        - project                         = "env0project" -> null
        - routing_mode                    = "REGIONAL" -> null
        - self_link                       = "https://www.googleapis.com/compute/v1/projects/env0project/global/networks/default-vpc" -> null
        }

    # module.cluster.google_compute_router.gke-outgoing-router will be destroyed
    - resource "google_compute_router" "gke-outgoing-router" {
        - creation_timestamp = "2020-01-16T08:12:17.665-08:00" -> null
        - id                 = "projects/env0project/regions/us-east1/routers/default-gke-outgoing-router" -> null
        - name               = "default-gke-outgoing-router" -> null
        - network            = "https://www.googleapis.com/compute/v1/projects/env0project/global/networks/default-vpc" -> null
        - project            = "env0project" -> null
        - region             = "us-east1" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/routers/default-gke-outgoing-router" -> null
        }

    # module.cluster.google_compute_router_nat.gke-outgoing-nat will be destroyed
    - resource "google_compute_router_nat" "gke-outgoing-nat" {
        - icmp_idle_timeout_sec              = 30 -> null
        - id                                 = "env0project/us-east1/default-gke-outgoing-router/default-gke-outgoing-nat" -> null
        - min_ports_per_vm                   = 16384 -> null
        - name                               = "default-gke-outgoing-nat" -> null
        - nat_ip_allocate_option             = "MANUAL_ONLY" -> null
        - nat_ips                            = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0",
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1",
            ] -> null
        - project                            = "env0project" -> null
        - region                             = "us-east1" -> null
        - router                             = "default-gke-outgoing-router" -> null
        - source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" -> null
        - tcp_established_idle_timeout_sec   = 1200 -> null
        - tcp_transitory_idle_timeout_sec    = 30 -> null
        - udp_idle_timeout_sec               = 30 -> null

        - log_config {
            - enable = true -> null
            - filter = "ALL" -> null
            }

        - subnetwork {
            - name                     = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/subnetworks/default-vpc" -> null
            - secondary_ip_range_names = [] -> null
            - source_ip_ranges_to_nat  = [
                - "ALL_IP_RANGES",
                ] -> null
            }
        }

    # module.cluster.google_container_cluster.cluster will be destroyed
    - resource "google_container_cluster" "cluster" {
        - cluster_ipv4_cidr         = "10.8.0.0/14" -> null
        - default_max_pods_per_node = 110 -> null
        - enable_kubernetes_alpha   = false -> null
        - enable_legacy_abac        = false -> null
        - endpoint                  = "104.196.137.78" -> null
        - id                        = "projects/env0project/locations/us-east1-b/clusters/default-cluster" -> null
        - initial_node_count        = 1 -> null
        - instance_group_urls       = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/zones/us-east1-b/instanceGroups/gke-default-cluster-default-node-pool-c0a170c4-grp",
            ] -> null
        - location                  = "us-east1-b" -> null
        - logging_service           = "logging.googleapis.com/kubernetes" -> null
        - master_version            = "1.14.10-gke.0" -> null
        - min_master_version        = "1.14.10-gke.0" -> null
        - monitoring_service        = "monitoring.googleapis.com/kubernetes" -> null
        - name                      = "default-cluster" -> null
        - network                   = "projects/env0project/global/networks/default-vpc" -> null
        - node_locations            = [] -> null
        - node_version              = "1.14.7-gke.10" -> null
        - project                   = "env0project" -> null
        - remove_default_node_pool  = true -> null
        - resource_labels           = {
            - "workspace" = "default"
            } -> null
        - services_ipv4_cidr        = "10.72.0.0/20" -> null
        - subnetwork                = "projects/env0project/regions/us-east1/subnetworks/default-vpc" -> null

        - addons_config {

            - network_policy_config {
                - disabled = true -> null
                }
            }

        - cluster_autoscaling {
            - enabled = false -> null
            }

        - ip_allocation_policy {
            - cluster_ipv4_cidr_block       = "10.8.0.0/14" -> null
            - cluster_secondary_range_name  = "gke-default-cluster-pods-baaf834f" -> null
            - create_subnetwork             = false -> null
            - services_ipv4_cidr_block      = "10.72.0.0/20" -> null
            - services_secondary_range_name = "gke-default-cluster-services-baaf834f" -> null
            - use_ip_aliases                = false -> null
            }

        - master_auth {
            - cluster_ca_certificate = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURERENDQWZTZ0F3SUJBZ0lSQUpNM1cxNkRpUExKMGZrdXVocUQzQ1l3RFFZSktvWklodmNOQVFFTEJRQXcKTHpFdE1Dc0dBMVVFQXhNa01qSTNZV0prTlRJdFlUWXpaaTAwWW1FeExUa3dZemd0TnpBeE1qZzNObUkwWkRNdwpNQjRYRFRJd01ERXhOakUxTVRJeE9Gb1hEVEkxTURFeE5ERTJNVEl4T0Zvd0x6RXRNQ3NHQTFVRUF4TWtNakkzCllXSmtOVEl0WVRZelppMDBZbUV4TFRrd1l6Z3ROekF4TWpnM05tSTBaRE13TUlJQklqQU5CZ2txaGtpRzl3MEIKQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBeW9wbFQ0dmFpV1NuQXhBRng1NlZ5WXRoTlIvUVZsNVRhNU9sNWdtRQovQmhoRXRuNm1MOXhsMFcxaGJaUlNyK1grZnRzR2FUQmNwRk9iWHNvVmk0TDJJY2hwUStyYVdoZXF1dmpTNS9FCkN5bGU2Qmk2czZ1QXVoeU9wcFByaVNXYlBYa1NDTEx0VHc4aTdMZGZtMHprVnU2djErdGRmdkRPbFNIVVFsVGsKKzNXbHovNmsrcEluaUdNTXFmbFZJUHR3QXJhejRNUGhjcTludUpKMGtsSHo5UlNmMU51TXJYUFhLalo2LzRwNwpuSkNHR3ZydDJ6STRDYWRJQjhCU2I3ZTNsbVNOMU12WEcyQ3M2RUQ3SG55MW1JVHcvTDFSRCtSVDE2S1NrZXo2ClRCQ0VIdjdLekIzNG1sbTRmcUprSVNQbTVyZGZMaS83cDNFd3ZRaVlaLzZkQXdJREFRQUJveU13SVRBT0JnTlYKSFE4QkFmOEVCQU1DQWdRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQVFFQQpIVW9Qa0NlSlRQcDNXeDJVcGFqU3h5RDFhMk03aXNIVTJPWmVtaDU5M1hTekJOeFVHSEE5MHlSd0kvRE5HTmVMCm1rdlJLb2xRc3p1UkdFR1JmeWkwdWlXYjlmYURTNFlxY3NZbGxJZ3ZOMytpb28rblE0R0FVaXJOYUVxWTZJLzkKcWlQV2J0dVNLQVl1b2Eva0JqSDA4djNUNXM0NHh4SkM2dWhlTzNsRzFZSk9qaVRzM2JwNnVOUllHME0xSktSMQo0MitQcksxOURNVGpidlI0eWI3bklxdkhpQ2xySnF6VUF3V1l3RlNpOUNtNS9VSWxuY0xHeUxtTkttUkVDY1dDCmN6TjRoNTBaTnlneUFiazVuaFpKaGcyRmRWeDdSdksrZ1M5ajQ2U1Q3VjlabjVmMXZOeDVZMkZIVFhnSys3NXoKMDF1VmNlNy9RdkdoU1hmUUlNbS9pZz09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K" -> null
            - password               = (sensitive value)
            - username               = "admin" -> null

            - client_certificate_config {
                - issue_client_certificate = false -> null
                }
            }

        - master_authorized_networks_config {
            - cidr_blocks {
                - cidr_block   = "0.0.0.0/0" -> null
                - display_name = "allow-all" -> null
                }
            }

        - network_policy {
            - enabled  = false -> null
            - provider = "PROVIDER_UNSPECIFIED" -> null
            }

        - node_config {
            - disk_size_gb      = 100 -> null
            - disk_type         = "pd-standard" -> null
            - guest_accelerator = [] -> null
            - image_type        = "COS" -> null
            - labels            = {
                - "workspace" = "default"
                } -> null
            - local_ssd_count   = 0 -> null
            - machine_type      = "n1-highcpu-8" -> null
            - metadata          = {
                - "disable-legacy-endpoints" = "true"
                } -> null
            - min_cpu_platform  = "Intel Haswell" -> null
            - oauth_scopes      = [
                - "https://www.googleapis.com/auth/compute",
                - "https://www.googleapis.com/auth/devstorage.read_only",
                - "https://www.googleapis.com/auth/logging.write",
                - "https://www.googleapis.com/auth/monitoring",
                ] -> null
            - preemptible       = false -> null
            - service_account   = "default" -> null
            - tags              = [] -> null
            - taint             = [] -> null

            - shielded_instance_config {
                - enable_integrity_monitoring = true -> null
                - enable_secure_boot          = false -> null
                }
            }

        - node_pool {
            - initial_node_count  = 1 -> null
            - instance_group_urls = [
                - "https://www.googleapis.com/compute/v1/projects/env0project/zones/us-east1-b/instanceGroupManagers/gke-default-cluster-default-node-pool-c0a170c4-grp",
                ] -> null
            - max_pods_per_node   = 110 -> null
            - name                = "default-node-pool" -> null
            - node_count          = 1 -> null
            - version             = "1.14.7-gke.10" -> null

            - autoscaling {
                - max_node_count = 2 -> null
                - min_node_count = 1 -> null
                }

            - management {
                - auto_repair  = true -> null
                - auto_upgrade = false -> null
                }

            - node_config {
                - disk_size_gb      = 100 -> null
                - disk_type         = "pd-standard" -> null
                - guest_accelerator = [] -> null
                - image_type        = "COS" -> null
                - labels            = {
                    - "workspace" = "default"
                    } -> null
                - local_ssd_count   = 0 -> null
                - machine_type      = "n1-highcpu-8" -> null
                - metadata          = {
                    - "disable-legacy-endpoints" = "true"
                    } -> null
                - min_cpu_platform  = "Intel Haswell" -> null
                - oauth_scopes      = [
                    - "https://www.googleapis.com/auth/compute",
                    - "https://www.googleapis.com/auth/devstorage.read_only",
                    - "https://www.googleapis.com/auth/logging.write",
                    - "https://www.googleapis.com/auth/monitoring",
                    ] -> null
                - preemptible       = false -> null
                - service_account   = "default" -> null
                - tags              = [] -> null
                - taint             = [] -> null

                - shielded_instance_config {
                    - enable_integrity_monitoring = true -> null
                    - enable_secure_boot          = false -> null
                    }
                }
            }

        - private_cluster_config {
            - enable_private_endpoint = false -> null
            - enable_private_nodes    = true -> null
            - master_ipv4_cidr_block  = "172.16.0.0/28" -> null
            - private_endpoint        = "172.16.0.2" -> null
            - public_endpoint         = "104.196.137.78" -> null
            }
        }

    # module.cluster.google_container_node_pool.node_pool will be destroyed
    - resource "google_container_node_pool" "node_pool" {
        - cluster             = "default-cluster" -> null
        - id                  = "projects/env0project/locations/us-east1-b/clusters/default-cluster/nodePools/default-node-pool" -> null
        - initial_node_count  = 1 -> null
        - instance_group_urls = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/zones/us-east1-b/instanceGroupManagers/gke-default-cluster-default-node-pool-c0a170c4-grp",
            ] -> null
        - location            = "us-east1-b" -> null
        - max_pods_per_node   = 110 -> null
        - name                = "default-node-pool" -> null
        - node_count          = 1 -> null
        - project             = "env0project" -> null
        - version             = "1.14.7-gke.10" -> null

        - autoscaling {
            - max_node_count = 2 -> null
            - min_node_count = 1 -> null
            }

        - management {
            - auto_repair  = true -> null
            - auto_upgrade = false -> null
            }

        - node_config {
            - disk_size_gb      = 100 -> null
            - disk_type         = "pd-standard" -> null
            - guest_accelerator = [] -> null
            - image_type        = "COS" -> null
            - labels            = {
                - "workspace" = "default"
                } -> null
            - local_ssd_count   = 0 -> null
            - machine_type      = "n1-highcpu-8" -> null
            - metadata          = {
                - "disable-legacy-endpoints" = "true"
                } -> null
            - min_cpu_platform  = "Intel Haswell" -> null
            - oauth_scopes      = [
                - "https://www.googleapis.com/auth/compute",
                - "https://www.googleapis.com/auth/devstorage.read_only",
                - "https://www.googleapis.com/auth/logging.write",
                - "https://www.googleapis.com/auth/monitoring",
                ] -> null
            - preemptible       = false -> null
            - service_account   = "default" -> null
            - tags              = [] -> null
            - taint             = [] -> null

            - shielded_instance_config {
                - enable_integrity_monitoring = true -> null
                - enable_secure_boot          = false -> null
                }
            }
        }

    # module.cluster.random_string.cluster_password will be destroyed
    - resource "random_string" "cluster_password" {
        - id          = "YJww(=l+yo)-F0BW-(cF{I(-(##MmU8N*U3$zk_f_HCA01}G3?" -> null
        - length      = 50 -> null
        - lower       = true -> null
        - min_lower   = 0 -> null
        - min_numeric = 0 -> null
        - min_special = 0 -> null
        - min_upper   = 0 -> null
        - number      = true -> null
        - result      = "YJww(=l+yo)-F0BW-(cF{I(-(##MmU8N*U3$zk_f_HCA01}G3?" -> null
        - special     = true -> null
        - upper       = true -> null
        }

    # module.kubernetes.kubernetes_storage_class.ssd will be destroyed
    - resource "kubernetes_storage_class" "ssd" {
        - allow_volume_expansion = true -> null
        - id                     = "ssd" -> null
        - parameters             = {
            - "type" = "pd-ssd"
            } -> null
        - reclaim_policy         = "Delete" -> null
        - storage_provisioner    = "kubernetes.io/gce-pd" -> null
        - volume_binding_mode    = "Immediate" -> null

        - metadata {
            - annotations      = {} -> null
            - generation       = 0 -> null
            - labels           = {} -> null
            - name             = "ssd" -> null
            - resource_version = "1353" -> null
            - self_link        = "/apis/storage.k8s.io/v1/storageclasses/ssd" -> null
            - uid              = "1284f3ae-387c-11ea-8da6-4201ac100003" -> null
            }
        }

    Plan: 0 to add, 0 to change, 10 to destroy.

    ------------------------------------------------------------------------

    This plan was saved to: destroy.tf-plan

    To perform exactly these actions, run the following command to apply:
        terraform apply "destroy.tf-plan"
      
      ```
      
  </p>
  </details>
  
6. Trying to apply the plan will fail, claiming there are cycles which aren't clear to me:  
    `➜ terraform apply destroy.tf-plan`
    <details><summary>(output)</summary>
    <p>
      
      ```              
    Error: Cycle: module.cluster.output.host, module.cluster.output.password, module.cluster.output.cluster_ca_certificate, provider.kubernetes, module.kubernetes.kubernetes_storage_class.ssd (destroy), module.cluster.google_container_cluster.cluster (destroy)
      
      ```
      
  </p>
  </details>

  
7. What's worse, trying to destroy rather than applying the destruction plan works:  
    `➜ terraform destroy`
    <details><summary>(output)</summary>
    <p>
      
      ```              
    module.cluster.random_string.cluster_password: Refreshing state... [id=BhsaSh(H#!bnB}-CX6bifs($CIRaEn{Ml]3O+W[P{@c*PVitX2]
    module.cluster.google_compute_network.network: Refreshing state... [id=projects/env0project/global/networks/default-vpc]
    module.cluster.google_compute_address.gke-outgoing-address[0]: Refreshing state... [id=projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0]
    module.cluster.google_compute_address.gke-outgoing-address[1]: Refreshing state... [id=projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1]
    module.cluster.data.google_container_engine_versions.valid_gke_versions: Refreshing state...
    module.cluster.google_compute_global_address.external-ip: Refreshing state... [id=projects/env0project/global/addresses/default-backend-ip]
    module.cluster.google_compute_router.gke-outgoing-router: Refreshing state... [id=projects/env0project/regions/us-east1/routers/default-gke-outgoing-router]
    module.cluster.google_container_cluster.cluster: Refreshing state... [id=projects/env0project/locations/us-east1-b/clusters/default-cluster]
    module.cluster.google_compute_router_nat.gke-outgoing-nat: Refreshing state... [id=env0project/us-east1/default-gke-outgoing-router/default-gke-outgoing-nat]
    module.cluster.google_container_node_pool.node_pool: Refreshing state... [id=projects/env0project/locations/us-east1-b/clusters/default-cluster/nodePools/default-node-pool]
    module.kubernetes.kubernetes_storage_class.ssd: Refreshing state... [id=ssd]

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
    - destroy

    Terraform will perform the following actions:

    # module.cluster.google_compute_address.gke-outgoing-address[0] will be destroyed
    - resource "google_compute_address" "gke-outgoing-address" {
        - address            = "35.231.97.206" -> null
        - address_type       = "EXTERNAL" -> null
        - creation_timestamp = "2020-01-16T06:43:11.220-08:00" -> null
        - id                 = "projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0" -> null
        - name               = "default-gke-outgoing-nat-address-0" -> null
        - network_tier       = "PREMIUM" -> null
        - project            = "env0project" -> null
        - region             = "us-east1" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0" -> null
        - users              = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/routers/default-gke-outgoing-router",
            ] -> null
        }

    # module.cluster.google_compute_address.gke-outgoing-address[1] will be destroyed
    - resource "google_compute_address" "gke-outgoing-address" {
        - address            = "35.237.142.252" -> null
        - address_type       = "EXTERNAL" -> null
        - creation_timestamp = "2020-01-16T06:43:11.339-08:00" -> null
        - id                 = "projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1" -> null
        - name               = "default-gke-outgoing-nat-address-1" -> null
        - network_tier       = "PREMIUM" -> null
        - project            = "env0project" -> null
        - region             = "us-east1" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1" -> null
        - users              = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/routers/default-gke-outgoing-router",
            ] -> null
        }

    # module.cluster.google_compute_global_address.external-ip will be destroyed
    - resource "google_compute_global_address" "external-ip" {
        - address            = "34.107.146.15" -> null
        - address_type       = "EXTERNAL" -> null
        - creation_timestamp = "2020-01-16T06:43:11.081-08:00" -> null
        - id                 = "projects/env0project/global/addresses/default-backend-ip" -> null
        - name               = "default-backend-ip" -> null
        - prefix_length      = 0 -> null
        - project            = "env0project" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/global/addresses/default-backend-ip" -> null
        }

    # module.cluster.google_compute_network.network will be destroyed
    - resource "google_compute_network" "network" {
        - auto_create_subnetworks         = true -> null
        - delete_default_routes_on_create = false -> null
        - id                              = "projects/env0project/global/networks/default-vpc" -> null
        - name                            = "default-vpc" -> null
        - project                         = "env0project" -> null
        - routing_mode                    = "REGIONAL" -> null
        - self_link                       = "https://www.googleapis.com/compute/v1/projects/env0project/global/networks/default-vpc" -> null
        }

    # module.cluster.google_compute_router.gke-outgoing-router will be destroyed
    - resource "google_compute_router" "gke-outgoing-router" {
        - creation_timestamp = "2020-01-16T06:43:59.995-08:00" -> null
        - id                 = "projects/env0project/regions/us-east1/routers/default-gke-outgoing-router" -> null
        - name               = "default-gke-outgoing-router" -> null
        - network            = "https://www.googleapis.com/compute/v1/projects/env0project/global/networks/default-vpc" -> null
        - project            = "env0project" -> null
        - region             = "us-east1" -> null
        - self_link          = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/routers/default-gke-outgoing-router" -> null
        }

    # module.cluster.google_compute_router_nat.gke-outgoing-nat will be destroyed
    - resource "google_compute_router_nat" "gke-outgoing-nat" {
        - icmp_idle_timeout_sec              = 30 -> null
        - id                                 = "env0project/us-east1/default-gke-outgoing-router/default-gke-outgoing-nat" -> null
        - min_ports_per_vm                   = 16384 -> null
        - name                               = "default-gke-outgoing-nat" -> null
        - nat_ip_allocate_option             = "MANUAL_ONLY" -> null
        - nat_ips                            = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-0",
            - "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/addresses/default-gke-outgoing-nat-address-1",
            ] -> null
        - project                            = "env0project" -> null
        - region                             = "us-east1" -> null
        - router                             = "default-gke-outgoing-router" -> null
        - source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" -> null
        - tcp_established_idle_timeout_sec   = 1200 -> null
        - tcp_transitory_idle_timeout_sec    = 30 -> null
        - udp_idle_timeout_sec               = 30 -> null

        - log_config {
            - enable = true -> null
            - filter = "ALL" -> null
            }

        - subnetwork {
            - name                     = "https://www.googleapis.com/compute/v1/projects/env0project/regions/us-east1/subnetworks/default-vpc" -> null
            - secondary_ip_range_names = [] -> null
            - source_ip_ranges_to_nat  = [
                - "ALL_IP_RANGES",
                ] -> null
            }
        }

    # module.cluster.google_container_cluster.cluster will be destroyed
    - resource "google_container_cluster" "cluster" {
        - cluster_ipv4_cidr         = "10.8.0.0/14" -> null
        - default_max_pods_per_node = 110 -> null
        - enable_kubernetes_alpha   = false -> null
        - enable_legacy_abac        = false -> null
        - endpoint                  = "35.196.124.50" -> null
        - id                        = "projects/env0project/locations/us-east1-b/clusters/default-cluster" -> null
        - initial_node_count        = 1 -> null
        - instance_group_urls       = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/zones/us-east1-b/instanceGroups/gke-default-cluster-default-node-pool-67368eb2-grp",
            ] -> null
        - location                  = "us-east1-b" -> null
        - logging_service           = "logging.googleapis.com/kubernetes" -> null
        - master_version            = "1.14.10-gke.0" -> null
        - min_master_version        = "1.14.10-gke.0" -> null
        - monitoring_service        = "monitoring.googleapis.com/kubernetes" -> null
        - name                      = "default-cluster" -> null
        - network                   = "projects/env0project/global/networks/default-vpc" -> null
        - node_locations            = [] -> null
        - node_version              = "1.14.7-gke.10" -> null
        - project                   = "env0project" -> null
        - remove_default_node_pool  = true -> null
        - resource_labels           = {
            - "workspace" = "default"
            } -> null
        - services_ipv4_cidr        = "10.72.0.0/20" -> null
        - subnetwork                = "projects/env0project/regions/us-east1/subnetworks/default-vpc" -> null

        - addons_config {

            - network_policy_config {
                - disabled = true -> null
                }
            }

        - cluster_autoscaling {
            - enabled = false -> null
            }

        - ip_allocation_policy {
            - cluster_ipv4_cidr_block       = "10.8.0.0/14" -> null
            - cluster_secondary_range_name  = "gke-default-cluster-pods-d72e3347" -> null
            - create_subnetwork             = false -> null
            - services_ipv4_cidr_block      = "10.72.0.0/20" -> null
            - services_secondary_range_name = "gke-default-cluster-services-d72e3347" -> null
            - use_ip_aliases                = false -> null
            }

        - master_auth {
            - cluster_ca_certificate = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURDekNDQWZPZ0F3SUJBZ0lRYmlVbUh3WGdsNTJ3ZEsvUjc3cDVVakFOQmdrcWhraUc5dzBCQVFzRkFEQXYKTVMwd0t3WURWUVFERXlRek5tSmpNR1k1T0MwMll6SmxMVFExWkRVdFlqSTRNeTFsWkRjMFpqRTRaV1psTnpjdwpIaGNOTWpBd01URTJNVE0wTXpVNVdoY05NalV3TVRFME1UUTBNelU1V2pBdk1TMHdLd1lEVlFRREV5UXpObUpqCk1HWTVPQzAyWXpKbExUUTFaRFV0WWpJNE15MWxaRGMwWmpFNFpXWmxOemN3Z2dFaU1BMEdDU3FHU0liM0RRRUIKQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUNraUpVTlZONmxnNy9HN3Q1R005WjIwd1VzclA0dXc4eGxleWlXTXdhKwpCUFdjWVFKNlVyQW1KeXlWVXZlZVBkZlY5Tk5KMkd2Q0FiUEVucG9KK1cvbGpGcEhyUXBtdnhQVU9Ta1hrNVdXCnZYcTZJblA1aWN5Nkd0VEVPbFdjYkdhdkhuTVZVTnJoVCtya1l6RHNFV1lhcEh5a002eFRzbnZMbFhZekZQVGUKS3hWanArZHVZN3RtQ2NaOXVqbTFRalFKdTdXTzdxTVViaUJXWWtPcTRRUWhoLzJ0NUQzNGxpTjRPZEhsVSszTwpSY1JPM2wyOXprQ0VVT1JwV1NLcTYzMERHM2twbkx5dThiaW4rNVhtUW0wbHo4MDdKRGJSbUFEUXNtMlpvSy8xCmxyS0lwQkVSMVZDTzd3aS9NQW5QWGFsZDB0R0o0MS9HdVBBTDM1Um4zTFJCQWdNQkFBR2pJekFoTUE0R0ExVWQKRHdFQi93UUVBd0lDQkRBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUEwR0NTcUdTSWIzRFFFQkN3VUFBNElCQVFCcQpoRTNyTW1SL2NER1YrWUVYeGs3MlY5N0VKdlUyaVVVNFZaVGhVM0J5MVZPVEY4UXdKSldkd09JZE55UklJVStaCm9VMHpocm93L0I2RnI5NG4zc3c5RDlFZld0dkp0WHhVY2JvaWhGLzRqdzJ6YlNleERsMU5HeU5RL0YvaFd4YzcKd1Vzc1JrVzNqbmg0UkpOS0YzTk1FcnhmVjg5MEVkZEFyTWFxTUJXVHFTcVVuMFFNQXB3OG1qNTVWSHhMVC9YSApyMHhETy8yYytXa0FIbk82bi81QWdRN1NwNUloYUxpdmlsdG9yMEprUnVoalNPL2o3ZHR5R2Zqb3hQbDlmamNWCksxQ2gxV3RIU3IxazB4djB1ZzAzUTVoNTUwdCtpNFU1aTJMRFhhYjlZMHdQOC80SEYwVVlldFVYWkNpems3WGcKbS93VnU0SG9idHc3dE16VDdOVnQKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=" -> null
            - password               = (sensitive value)
            - username               = "admin" -> null

            - client_certificate_config {
                - issue_client_certificate = false -> null
                }
            }

        - master_authorized_networks_config {
            - cidr_blocks {
                - cidr_block   = "0.0.0.0/0" -> null
                - display_name = "allow-all" -> null
                }
            }

        - network_policy {
            - enabled  = false -> null
            - provider = "PROVIDER_UNSPECIFIED" -> null
            }

        - node_config {
            - disk_size_gb      = 100 -> null
            - disk_type         = "pd-standard" -> null
            - guest_accelerator = [] -> null
            - image_type        = "COS" -> null
            - labels            = {
                - "workspace" = "default"
                } -> null
            - local_ssd_count   = 0 -> null
            - machine_type      = "n1-highcpu-8" -> null
            - metadata          = {
                - "disable-legacy-endpoints" = "true"
                } -> null
            - min_cpu_platform  = "Intel Haswell" -> null
            - oauth_scopes      = [
                - "https://www.googleapis.com/auth/compute",
                - "https://www.googleapis.com/auth/devstorage.read_only",
                - "https://www.googleapis.com/auth/logging.write",
                - "https://www.googleapis.com/auth/monitoring",
                ] -> null
            - preemptible       = false -> null
            - service_account   = "default" -> null
            - tags              = [] -> null
            - taint             = [] -> null

            - shielded_instance_config {
                - enable_integrity_monitoring = true -> null
                - enable_secure_boot          = false -> null
                }
            }

        - node_pool {
            - initial_node_count  = 1 -> null
            - instance_group_urls = [
                - "https://www.googleapis.com/compute/v1/projects/env0project/zones/us-east1-b/instanceGroupManagers/gke-default-cluster-default-node-pool-67368eb2-grp",
                ] -> null
            - max_pods_per_node   = 110 -> null
            - name                = "default-node-pool" -> null
            - node_count          = 1 -> null
            - version             = "1.14.7-gke.10" -> null

            - autoscaling {
                - max_node_count = 2 -> null
                - min_node_count = 1 -> null
                }

            - management {
                - auto_repair  = true -> null
                - auto_upgrade = false -> null
                }

            - node_config {
                - disk_size_gb      = 100 -> null
                - disk_type         = "pd-standard" -> null
                - guest_accelerator = [] -> null
                - image_type        = "COS" -> null
                - labels            = {
                    - "workspace" = "default"
                    } -> null
                - local_ssd_count   = 0 -> null
                - machine_type      = "n1-highcpu-8" -> null
                - metadata          = {
                    - "disable-legacy-endpoints" = "true"
                    } -> null
                - min_cpu_platform  = "Intel Haswell" -> null
                - oauth_scopes      = [
                    - "https://www.googleapis.com/auth/compute",
                    - "https://www.googleapis.com/auth/devstorage.read_only",
                    - "https://www.googleapis.com/auth/logging.write",
                    - "https://www.googleapis.com/auth/monitoring",
                    ] -> null
                - preemptible       = false -> null
                - service_account   = "default" -> null
                - tags              = [] -> null
                - taint             = [] -> null

                - shielded_instance_config {
                    - enable_integrity_monitoring = true -> null
                    - enable_secure_boot          = false -> null
                    }
                }
            }

        - private_cluster_config {
            - enable_private_endpoint = false -> null
            - enable_private_nodes    = true -> null
            - master_ipv4_cidr_block  = "172.16.0.0/28" -> null
            - private_endpoint        = "172.16.0.2" -> null
            - public_endpoint         = "35.196.124.50" -> null
            }
        }

    # module.cluster.google_container_node_pool.node_pool will be destroyed
    - resource "google_container_node_pool" "node_pool" {
        - cluster             = "default-cluster" -> null
        - id                  = "projects/env0project/locations/us-east1-b/clusters/default-cluster/nodePools/default-node-pool" -> null
        - initial_node_count  = 1 -> null
        - instance_group_urls = [
            - "https://www.googleapis.com/compute/v1/projects/env0project/zones/us-east1-b/instanceGroupManagers/gke-default-cluster-default-node-pool-67368eb2-grp",
            ] -> null
        - location            = "us-east1-b" -> null
        - max_pods_per_node   = 110 -> null
        - name                = "default-node-pool" -> null
        - node_count          = 1 -> null
        - project             = "env0project" -> null
        - version             = "1.14.7-gke.10" -> null

        - autoscaling {
            - max_node_count = 2 -> null
            - min_node_count = 1 -> null
            }

        - management {
            - auto_repair  = true -> null
            - auto_upgrade = false -> null
            }

        - node_config {
            - disk_size_gb      = 100 -> null
            - disk_type         = "pd-standard" -> null
            - guest_accelerator = [] -> null
            - image_type        = "COS" -> null
            - labels            = {
                - "workspace" = "default"
                } -> null
            - local_ssd_count   = 0 -> null
            - machine_type      = "n1-highcpu-8" -> null
            - metadata          = {
                - "disable-legacy-endpoints" = "true"
                } -> null
            - min_cpu_platform  = "Intel Haswell" -> null
            - oauth_scopes      = [
                - "https://www.googleapis.com/auth/compute",
                - "https://www.googleapis.com/auth/devstorage.read_only",
                - "https://www.googleapis.com/auth/logging.write",
                - "https://www.googleapis.com/auth/monitoring",
                ] -> null
            - preemptible       = false -> null
            - service_account   = "default" -> null
            - tags              = [] -> null
            - taint             = [] -> null

            - shielded_instance_config {
                - enable_integrity_monitoring = true -> null
                - enable_secure_boot          = false -> null
                }
            }
        }

    # module.cluster.random_string.cluster_password will be destroyed
    - resource "random_string" "cluster_password" {
        - id          = "BhsaSh(H#!bnB}-CX6bifs($CIRaEn{Ml]3O+W[P{@c*PVitX2" -> null
        - length      = 50 -> null
        - lower       = true -> null
        - min_lower   = 0 -> null
        - min_numeric = 0 -> null
        - min_special = 0 -> null
        - min_upper   = 0 -> null
        - number      = true -> null
        - result      = "BhsaSh(H#!bnB}-CX6bifs($CIRaEn{Ml]3O+W[P{@c*PVitX2" -> null
        - special     = true -> null
        - upper       = true -> null
        }

    # module.kubernetes.kubernetes_storage_class.ssd will be destroyed
    - resource "kubernetes_storage_class" "ssd" {
        - allow_volume_expansion = true -> null
        - id                     = "ssd" -> null
        - parameters             = {
            - "type" = "pd-ssd"
            } -> null
        - reclaim_policy         = "Delete" -> null
        - storage_provisioner    = "kubernetes.io/gce-pd" -> null
        - volume_binding_mode    = "Immediate" -> null

        - metadata {
            - annotations      = {} -> null
            - generation       = 0 -> null
            - labels           = {} -> null
            - name             = "ssd" -> null
            - resource_version = "894" -> null
            - self_link        = "/apis/storage.k8s.io/v1/storageclasses/ssd" -> null
            - uid              = "6cc51038-386f-11ea-9648-4201ac100003" -> null
            }
        }

    Plan: 0 to add, 0 to change, 10 to destroy.

    Do you really want to destroy all resources?
    Terraform will destroy all your managed infrastructure, as shown above.
    There is no undo. Only 'yes' will be accepted to confirm.

    Enter a value: yes

    ...

    Destroy complete! Resources: 10 destroyed.
      
      ```
      
  </p>
  </details>
