locals {
  workflow_env_vars = {
    CHANNEL_ID           = "UCfhyVWrxCmdUpst-5n7Kz_Q",
    CACHE_BUCKET_NAME    = google_storage_bucket.cache.name,
    METADATA_BUCKET_NAME = google_storage_bucket.metadata.name
    PUBLIC_BUCKET_NAME   = google_storage_bucket.public.name
  }
}

resource "google_workflows_workflow" "fetch_latest_search_list" {
  name            = "fetch-latest-search-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
}

resource "google_workflows_workflow" "fetch_all_search_list" {
  name            = "fetch-all-search-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
}

resource "google_workflows_workflow" "fetch_all_video_list" {
  name            = "fetch-all-video-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-all-video-list.yaml")
}
