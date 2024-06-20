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

module "gke" {
  source       = "./gke"
  project_name = var.project_name
  region       = var.region
  vpc_network  = module.network.vpc_network
}

resource "google_compute_firewall" "http" {
  name    = "http-firewall-rule"
  network = module.network.vpc_network

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["allow-http"]
  target_tags = ["allow-http"]
}