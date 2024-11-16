terraform {
  backend "gcs" {
    bucket = "${secrets.TERRAFORM_STATE_BUCKET}"
    prefix = "testing/terraform.tfstate"
  }
}
