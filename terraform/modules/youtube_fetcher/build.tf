resource "google_cloudbuild_trigger" "workflows_main" {
  name     = "youtube-fetcher-workflows-main"
  location = "asia-east1"
  project  = var.project_id
  repository_event_config {
    repository = var.cloudbuild_trigger_repository
    push {
      branch = "^main$"
    }
  }
  substitutions = {
    "_RUN_SERVICE_ACCOUNT" = google_service_account.functions.email
    "_SERVICE_ACCOUNT"     = google_service_account.functions.email
  }
  filename           = ".cloudbuild/workflows/youtube-fetcher-workflows-main.yaml"
  service_account    = google_service_account.workflows_cb_main.id
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
}
