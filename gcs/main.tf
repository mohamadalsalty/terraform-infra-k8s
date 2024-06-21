resource "google_storage_bucket" "tf-state" {
  name     = var.name
  location = var.region

  uniform_bucket_level_access = true
  labels = {
    environment = "terraform"
  }
}