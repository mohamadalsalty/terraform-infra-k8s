module "gcs" {
  source       = "./gcs"
  project_name = var.project_name
  region       = var.region
  name         = var.bucket_name
}

module "network" {
  source               = "./network"
  project_name         = var.project_name
  region               = var.region
  vpc_name             = var.vpc_name
  subnet_node_name     = var.subnet_node_name
  subnet_pods_name     = var.subnet_pods_name
  subnet_services_name = var.subnet_services_name
}

module "gke" {
  source               = "./gke"
  project_name         = var.project_name
  region               = var.region
  vpc_network          = module.network.vpc_network
  subnet_link          = module.network.vpc_subnet_nodes
  subnet_pods_name     = var.subnet_pods_name
  subnet_node_name     = var.subnet_node_name
  subnet_services_name = var.subnet_services_name
  k8s_cluster_name     = var.k8s_cluster_name
}

module "secrets" {
  source           = "./secrets"
  project_name     = var.project_name
  secrets_k8s_name = var.secrets_k8s_name
}

module "iam" {
  source       = "./iam"
  project_name = var.project_name
  region       = var.region
  sa_name      = var.sa_name
}