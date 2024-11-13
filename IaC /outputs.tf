output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
  description = "The endpoint for GKE Kubernetes cluster"
}

output "alert_policy_name" {
  value = google_monitoring_alert_policy.high_cpu_alert.display_name
  description = "High CPU alert policy name"
}

output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
  description = "The name of the VPC network for the environment"
}