provider "google" {
  credentials =  "${file(secrets.GCP_CREDENTIALS_FILE)}"
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}

