resource "google_compute_network" "vpc_network" {
  name                    = "k8s-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet-nodes" {
  name          = "k8s-subnet-nodes"
  ip_cidr_range = "10.0.0.0/16"

  secondary_ip_range {
    range_name    = "k8s-subnet-services"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "k8s-subnet-pods"
    ip_cidr_range = "10.2.0.0/16"
  }

  region     = var.region
  network    = google_compute_network.vpc_network.id
  depends_on = [google_compute_network.vpc_network]
}

output "vpc_network" {
  value = google_compute_network.vpc_network.name
}
