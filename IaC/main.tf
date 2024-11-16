resource "google_container_cluster" "primary" {
  name     = "${var.environment}-gke-cluster"                 
  location = var.GCP_ZONE                                     
  initial_node_count = var.environment == "production" ? 5 : 2  

  node_config {
    machine_type = var.environment == "production" ? "e2-standard-4" : "e2-medium"  
  }
}

resource "google_monitoring_alert_policy" "high_cpu_alert" {
  display_name = "${var.environment}-High CPU Usage Alert"   
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

  notification_channels = [google_monitoring_notification_channel.email.id]
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "${var.environment}-notification-channel"
  type         = "email"
  
  labels = {
    email_address = "alerts@example.com" 
  }
}


resource "google_compute_network" "vpc_network" {
  name                    = "${var.environment}-vpc-network"   
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-subnet"
  region        = var.GCP_REGION
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.environment == "production" ? "10.0.0.0/16" : "10.1.0.0/16" 
}

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

