provider "google" {
  project = var.project_name
  region  = var.region
}

variables {
  vpc_name         = "test-${var.vpc_name}"
  subnet_node_name = "test-${var.subnet_node_name}"
  bucket_name      = "test-${var.bucket_name}"
  k8s_cluster_name = "test-${var.k8s_cluster_name}"
  secrets_k8s_name = "test-${var.secrets_k8s_name}"
  sa_name          = "test-${var.sa_name}"
}

run "validate_vars" {
  command = plan
  assert {
    condition     = module.network.vpc_network == var.vpc_name
    error_message = "The name of the VPC is wrong"
  }
  assert {
    condition     = module.network.vpc_subnet_nodes == var.subnet_node_name
    error_message = "The name of the subnet is wrong"
  }
  assert {
    condition     = module.secrets.secret_id == var.secrets_k8s_name
    error_message = "The name of the secret is wrong"
  }

  assert {
    condition     = module.iam.sa_for_k8s.account_id == var.sa_name
    error_message = "The name of the serviceaccount is wrong"
  }

}


run "create_infra" {
  command = apply
  assert {
    condition     = module.network.vpc_network == var.vpc_name
    error_message = "The vpc was not created"
  }
  assert {
    condition     = module.network.vpc_subnet_nodes == var.subnet_node_name
    error_message = "The subnet was not created"
  }
  assert {
    condition     = module.gke.gke_name == var.k8s_cluster_name
    error_message = "The cluster was not created"
  }
  assert {
    condition     = module.secrets.secret_id == var.secrets_k8s_name
    error_message = "The secret for k8s was not created"
  }

  assert {
    condition     = module.iam.sa_for_k8s.account_id == var.sa_name
    error_message = "The name of the serviceaccount was not created"
  }
}
