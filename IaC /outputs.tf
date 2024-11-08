output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}
