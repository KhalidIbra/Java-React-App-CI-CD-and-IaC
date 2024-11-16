terraform {
  backend "gcs" {
    bucket = "ki-terraform-state-bucket"
    prefix = "testing/terraform.tfstate"
  }
}
