#####################################################################
# Providers
#####################################################################
provider "google" {
  version = "3.3.0"
  project = var.gcp_project
  region = var.gcp_region
  zone = var.gcp_zone
  credentials = var.gcp_credentials
}

provider "google-beta" {
  version = "3.3.0"
  project = var.gcp_project
  region = var.gcp_region
  zone = var.gcp_zone
  credentials = var.gcp_credentials
}

provider "kubernetes" {
  version = "1.9.0"
  host = "https://${module.cluster.host}"
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
  username = var.cluster_username
  password = module.cluster.password
}

provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "2.2.1"
}

provider "external" {
  version = "1.2.0"
}

provider "tls" {
  version = "2.1.1"
}

#####################################################################
# Locals
#####################################################################
locals {
  workspace_name = terraform.workspace
}

#####################################################################
# Modules
#####################################################################
module "cluster" {
  source = "./modules/cluster"

  gcp_region = var.gcp_region
  gcp_zone = var.gcp_zone
  gcp_project = var.gcp_project
  workspace_name = local.workspace_name
  username = var.cluster_username
  cluster_zones = var.cluster_zones
}

module "kubernetes" {
  source = "./modules/kubernetes"
}
