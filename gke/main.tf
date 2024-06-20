# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

locals {
  zone = "us-east5-b"
}


module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_name
  name                       = "gke"
  region                     = var.region
  network                    = var.vpc_network
  subnetwork                 = "k8s-subnet-nodes"
  ip_range_pods              = "k8s-subnet-pods"
  ip_range_services          = "k8s-subnet-services"
  http_load_balancing        = false
  network_policy             = true
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  remove_default_node_pool   = true
  regional                   = false
  zones                      = [local.zone]
  deletion_protection        = false
  master_authorized_networks = [
    {
      cidr_block   = "8.8.8.8/32"
      display_name = "default"
    }
  ]


  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = local.zone
      min_count          = 1
      max_count          = 1
      initial_node_count = 1
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      default            = false
      service_account    = "default"
      preemptible        = false
    },

  ]
  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = false
    }

  }


}
