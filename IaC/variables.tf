 variable "GCP_CREDENTIALS_FILE" {
     type = string
     default = "/Users/khalidibrahim/spring-boot-react-example/IaC /my-new-project-441421-8f2d27d1390b.json"
     sensitive = true 
}

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
