provider "google" {
  project = var.project_name
  region  = var.region
}
terraform {
  backend "gcs" {
    bucket = "tf-state-pipelineformidable-bank-427016-h1"
    prefix = "terraform/state"
  }
}
