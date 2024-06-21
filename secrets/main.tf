resource "google_secret_manager_secret" "my_sa_for_k8s" {
  replication {
    auto {}
  }
  secret_id = var.secrets_k8s_name
  labels = {
    label = "k8s-secrets"
  }
}

output "secret_id" {
  value      = google_secret_manager_secret.my_sa_for_k8s.secret_id
  depends_on = [google_secret_manager_secret.my_sa_for_k8s]
}