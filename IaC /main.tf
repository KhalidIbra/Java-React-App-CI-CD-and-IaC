# Set up Google provider for Terraform
provider "google" {
  credentials = file(var.GCP_CREDENTIALS_FILE)
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}

# Define environment variable (injected by GitHub Actions workflow)
variable "environment" {
  description = "Deployment environment, can be 'testing' or 'production'"
}

# Define GKE Cluster with environment-specific settings
resource "google_container_cluster" "primary" {
  name     = "${var.environment}-gke-cluster"                 # Cluster name based on environment
  location = var.GCP_ZONE                                     # Use zone from variable
  initial_node_count = var.environment == "production" ? 5 : 2  # Use larger cluster in production

  node_config {
    machine_type = var.environment == "production" ? "e2-standard-4" : "e2-medium"  # Use more powerful instances in production
  }
}

# Define Google Cloud Monitoring Alert Policy
resource "google_monitoring_alert_policy" "high_cpu_alert" {
  display_name = "${var.environment}-High CPU Usage Alert"   # Alert name includes environment
  combiner     = "OR"

  conditions {
    display_name = "CPU usage high"
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "60s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  # Use an email or Slack notification channel here if needed
  notification_channels = [google_monitoring_notification_channel.email.id]
}

# Google Monitoring Notification Channel (example: email)
resource "google_monitoring_notification_channel" "email" {
  display_name = "${var.environment}-notification-channel"
  type         = "email"
  
  labels = {
    email_address = "alerts@example.com"  # Replace with actual email for alert notifications
  }
}

# Define a VPC network for the environment
resource "google_compute_network" "vpc_network" {
  name                    = "${var.environment}-vpc-network"   # Separate VPC for each environment
  auto_create_subnetworks = false
}

# Define a subnet within the VPC network
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-subnet"
  region        = var.GCP_REGION
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.environment == "production" ? "10.0.0.0/16" : "10.1.0.0/16"  # Use different IP ranges per environment
}

# IAM Role for Kubernetes Cluster Admin (optional, based on requirements)
resource "google_project_iam_member" "gke_admin" {
  project = var.GCP_PROJECT_ID
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_admin.email}"
}

# Service Account for GKE
resource "google_service_account" "gke_admin" {
  account_id   = "${var.environment}-gke-admin"
  display_name = "${var.environment} GKE Admin Service Account"
}

# Output Kubernetes cluster endpoint for reference
output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
  description = "The endpoint for GKE Kubernetes cluster"
}

# Output for Monitoring alert policy name
output "alert_policy_name" {
  value = google_monitoring_alert_policy.high_cpu_alert.display_name
  description = "High CPU alert policy name"
}

# Output VPC network name for environment
output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
  description = "The name of the VPC network for the environment"
}
