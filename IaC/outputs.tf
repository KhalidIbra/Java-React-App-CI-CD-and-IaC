output "backend_url" {
  value       = google_cloud_run_service.backend.status[0].url
  description = "URL for the backend service"
}


output "alert_policy_name" {
  value = google_monitoring_alert_policy.high_cpu_alert.display_name
  description = "High CPU alert policy name"
}

output "frontend_url" {
  value       = google_cloud_run_service.frontend.status[0].url
  description = "URL for the frontend service"
}