resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet_nodes" {
  name          = var.subnet_node_name
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

output "vpc_subnet_nodes" {
  value = google_compute_subnetwork.vpc_subnet_nodes.name
}