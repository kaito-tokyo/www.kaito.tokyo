resource "google_artifact_registry_repository" "run" {
  location      = "asia-east1"
  repository_id = "ns-run"
  format        = "DOCKER"
}
