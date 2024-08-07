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
resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "60s"
}

module "gke" {
  version                         = "31.0.0"
  source                          = "terraform-google-modules/kubernetes-engine/google"
  project_id                      = var.project_name
  name                            = var.k8s_cluster_name
  region                          = var.region
  network                         = var.vpc_network
  subnetwork                      = var.subnet_node_name
  ip_range_pods                   = var.subnet_pods_name
  ip_range_services               = var.subnet_services_name
  http_load_balancing             = false
  network_policy                  = true
  horizontal_pod_autoscaling      = true
  filestore_csi_driver            = false
  remove_default_node_pool        = true
  regional                        = false
  zones                           = [local.zone]
  deletion_protection             = false
  enable_vertical_pod_autoscaling = true

  cluster_autoscaling = {
    enabled                     = true
    min_cpu_cores               = 2
    max_cpu_cores               = 30
    min_memory_gb               = 10
    max_memory_gb               = 70
    auto_repair                 = true
    auto_upgrade                = true
    autoscaling_profile         = "BALANCED"
    gpu_resources               = []
    enable_integrity_monitoring = true
    max_surge                   = 1
    max_unavailable             = 1
    auto_upgrade                = true
    strategy                    = "SURGE"
  }

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "default"
    }
  ]


  node_pools = [
    {
      name                        = "pool-1"
      enable_integrity_monitoring = true
      machine_type                = "e2-standard-2"
      node_locations              = local.zone
      min_count                   = 3
      max_count                   = 5
      initial_node_count          = 1
      local_ssd_count             = 0
      spot                        = false
      disk_size_gb                = 50
      disk_type                   = "pd-standard"
      image_type                  = "COS_CONTAINERD"
      enable_gcfs                 = false
      enable_gvnic                = false
      logging_variant             = "DEFAULT"
      auto_repair                 = true
      auto_upgrade                = true
      default                     = false
      service_account             = "default"
      preemptible                 = false
    },
  ]


  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = false
    }

  }
  depends_on                        = [var.subnet_link, time_sleep.wait_60_seconds]
  disable_legacy_metadata_endpoints = true

}
output "gke_name" {
  value      = module.gke.name
  depends_on = [module.gke]
}
