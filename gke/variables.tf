variable "project_name" {
  description = "The project name"
  type        = string
}

variable "region" {
  description = "The region"
  type        = string
}
variable "vpc_network" {
  description = "The vpc network name"
  type        = string
}

variable "subnet_node_name" {
  description = "The node subnet name"
  type        = string
}

variable "subnet_pods_name" {
  description = "The pods subnet name"
  type        = string
}

variable "subnet_services_name" {
  description = "The services subnet name"
  type        = string
}

variable "k8s_cluster_name" {
  description = "The gke cluster name"
  type        = string
}

variable "subnet_link" {
  description = "The subnet link"
}