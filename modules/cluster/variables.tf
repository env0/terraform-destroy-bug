variable "gcp_region" {}
variable "gcp_zone" {}
variable "gcp_project" {}
variable "workspace_name" {}
# variable "is_main_workspace" {}
# variable "env_type" {}
variable "master_gke_version_prefix" {
  //https://drive.google.com/open?id=1QiD8KxythS2wzQfTFMSGeeQBb3eauqIYde61VGJVhM4
  default = "1.14."
  description = "clsuter master version will be no lower than the version specified here"
}
variable "node_gke_version" {
  default = "1.14.7-gke.10"
}
variable "username" {
  default = "admin"
}
variable "cluster_zones" {
  type  = list
}

variable "portshift_enabled" {
  default = false
}