provider "google" {
  credentials = file("sa.json")
  project     = var.project_name
  region      = var.region
}
terraform {
  required_version = "= 1.8.2"
  backend "gcs" {
    bucket = "tf-state-pipelineformidable-bank-427016-h1"
    prefix = "terraform/state"
  }
}
