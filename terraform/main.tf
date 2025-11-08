provider "google" {
  project = var.project_id
  region  = var.region
}


variable "project_id" {}
variable "region" {
  default = "us-central1"
}

resource "google_storage_bucket" "demo" {
  name     = "ariyansappdev11-${var.project_id}"
  location = upper(var.region)
  uniform_bucket_level_access = true
}
