module "gcs" {
  source       = "./gcs"
  project_name = var.project_name
  region       = var.region
}

module "network" {
  source       = "./network"
  project_name = var.project_name
  region       = var.region
}

# module "gke" {
#   source       = "./gke"
#   project_name = var.project_name
#   region       = var.region
#   vpc_network  = module.network.vpc_network
# }
