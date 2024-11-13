terraform {
  backend "gcs" {
    bucket = "ki-terraform-state-bucket"
  }
}
