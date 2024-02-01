resource "google_service_account" "youtube_fetcher_workflow" {
  project    = var.project_id
  account_id = "youtube-fetcher-workflow"
}

resource "google_workflows_workflow" "youtube_fetcher" {
  project = var.project_id
  region = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow
  source_contents = file("${path.module}/youtube-fetcher.yaml")
}

resource "google_service_account" "youtube_fetcher" {
  project    = var.project_id
  account_id = "youtube-fetcher"
}
