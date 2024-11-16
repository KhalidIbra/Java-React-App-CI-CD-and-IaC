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
variable "CLUSTER_NAME"  { 
    type = string
    default = "my-gke-cluster" 
}
variable "environment" {
  description = "The deployment environment (e.g., testing or production)"
  type        = string
}  