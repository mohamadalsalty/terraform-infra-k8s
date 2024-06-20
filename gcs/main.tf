resource "google_storage_bucket" "tf-state" {
  name     = "tf-state-pipeline${var.project_name}"
  location = var.region

  uniform_bucket_level_access = true
  labels = {
    environment = "terraform"
  }
}