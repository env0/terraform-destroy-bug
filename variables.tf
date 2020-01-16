variable "cluster_username" {
  default = "admin"
}

variable "cluster_zones" {
  type = list
  default = []
}
variable "gcp_project" {}
variable "gcp_region" {}
variable "gcp_zone" {}
variable "gcp_credentials" {}
variable "debug" {
  default = "false"
}
variable "required-transaction-confirmations" {
  default = 3
}
variable "key_data_stores_force_destroy" {
  default = false
}
