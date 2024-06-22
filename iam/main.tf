resource "google_service_account" "sa_for_k8s" {
  account_id   = var.sa_name
  display_name = "K8s Secret Manager Service Account"
}

resource "google_project_iam_member" "secret_manager_access_for_k8s" {
  project    = var.project_name
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.sa_for_k8s.email}"
  depends_on = [google_service_account.sa_for_k8s]
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.sa_for_k8s.name
  keepers = {
    "request_time" = timestamp()
  }
  private_key_type = "TYPE_GOOGLE_CREDENTIALS_FILE"
  lifecycle {
    ignore_changes = all
  }
}

resource "google_project_iam_member" "secret_manager_access" {
  project    = var.project_name
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.sa_for_k8s.email}"
  depends_on = [google_service_account.sa_for_k8s, google_project_iam_member.secret_manager_access_for_k8s, google_service_account_key.sa_key]
}
output "sa_for_k8s" {
  value      = google_service_account.sa_for_k8s
  depends_on = [google_service_account.sa_for_k8s]
}