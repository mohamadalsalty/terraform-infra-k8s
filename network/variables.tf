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
}

variable "subnet_services_name" {
  description = "The services subnet name"
  type        = string
}