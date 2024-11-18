variable "GCP_PROJECT_ID" {
    type = string
    default = "my-new-project-441421"
}
variable "GCP_REGION" {
    type = string
    default = "us-central1" 
}
variable "GCP_ZONE" { 
    type = string
    default = "us-central1-a"
}
variable "GCP_CREDENTIALS_FILE" {
  description = "The path to the Google Cloud service account credentials file"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., testing or production)"
  type        = string
}  