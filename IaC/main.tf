resource "google_cloud_run_service" "backend" {
  name     = "${var.environment}-backend-service"
  location = var.GCP_REGION

  template {
    spec {
      containers {
        image = "gcr.io/${var.GCP_PROJECT_ID}/backend:latest"  
        ports {
          container_port = 8080  
        }
      }
    }
  }
}

resource "google_cloud_run_service" "frontend" {
  name     = "${var.environment}-frontend-service"
  location = var.GCP_REGION

  template {
    spec {
      containers {
        image = "gcr.io/${var.GCP_PROJECT_ID}/frontend:latest"  
        ports {
          container_port = 8080  
        }
      }
    }
  }
}


resource "google_monitoring_notification_channel" "email" {
  for_each = toset([
    "developer1@example.com",
    "developer2@example.com"
  ])

  display_name = "${var.environment}-notification-channel-${each.value}"
  type         = "email"

  labels = {
    email_address = each.value
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

  notification_channels = [
    for nc in google_monitoring_notification_channel.email : nc.id
  ]
}
