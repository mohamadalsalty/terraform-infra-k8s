variable "project_name" {
  description = "The project name"
  type        = string
}

variable "region" {
  description = "The region"
  type        = string
}

variable "vpc_name" {
  description = "The VPC name"
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

variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "k8s_cluster_name" {
  description = "The gke cluster name"
  type        = string
}

variable "secrets_k8s_name" {
  description = "THe secrets name"
  type        = string
}

variable "sa_name" {
  description = "The service account name"
  type        = string
}