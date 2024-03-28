resource "google_cloud_workflow_workflow" "fetch_latest_search_list" {
  name            = "youtube-fetcher-fetch-latest-search-list"
  location        = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
}

resource "google_cloud_workflow_workflow" "fetch_all_search_list" {
  name            = "youtube-fetcher-fetch-all-search-list"
  location        = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
}

resource "google_cloud_workflow_workflow" "fetch_all_video_list" {
  name            = "youtube-fetcher-fetch-latest-search-list"
  location        = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-video-list.yaml")
}
