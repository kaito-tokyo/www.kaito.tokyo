output "run_repository" {
  value = "${google_artifact_registry_repository.run.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.run.repository_id}"
}
