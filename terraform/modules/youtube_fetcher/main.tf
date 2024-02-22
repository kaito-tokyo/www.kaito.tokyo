// Service accounts
resource "google_service_account" "youtube_fetcher_workflow" {
  project    = var.project_id
  account_id = "youtube-fetcher-workflow"
}

resource "google_service_account" "youtube_fetcher_functions" {
  project    = var.project_id
  account_id = "youtube-fetcher-functions"
}

resource "google_service_account" "cloudbuild_youtube_fetcher_functions_main" {
  project    = var.project_id
  account_id = "cloudbuild-youtube-fetcher-functions-main"
}

// Cloud Build Triggers
resource "google_cloudbuild_trigger" "youtube_fetcher_functions_main" {
  location = "asia-east1"
  repository_event_config {
    repository = "kaito-tokyo-www.kaito.tokyo"
    push {
      branch = "^main$"
    }
  }
  filename           = ".cloudbuild/workflows/youtube-fetcher-cloud-functions-main.yaml"
  service_account    = google_service_account.cloudbuild_youtube_fetcher_functions_main.email
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
}

// Cloud Storage Buckets
resource "google_storage_bucket" "youtube_fetcher_cache" {
  name                        = "${var.project_id}-youtube-fetcher-cache"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "youtube_fetcher_metadata" {
  name                        = "${var.project_id}-youtube-fetcher-metadata"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "youtube_fetcher_public" {
  name                        = "${var.project_id}-youtube-fetcher-public"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}

// Cloud Workflows
locals {
  workflow_env_vars = {
    CHANNEL_ID           = "UCfhyVWrxCmdUpst-5n7Kz_Q",
    CACHE_BUCKET_NAME    = google_storage_bucket.youtube_fetcher_cache.name,
    METADATA_BUCKET_NAME = google_storage_bucket.youtube_fetcher_metadata.name
    PUBLIC_BUCKET_NAME   = google_storage_bucket.youtube_fetcher_public.name
  }
}

resource "google_workflows_workflow" "fetch_latest_search_list" {
  name            = "fetch-latest-search-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
}

resource "google_workflows_workflow" "fetch_all_search_list" {
  name            = "fetch-all-search-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
}

resource "google_workflows_workflow" "fetch_all_video_list" {
  name            = "fetch-all-video-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-all-video-list.yaml")
}

// Project IAM Bindings
resource "google_project_iam_member" "youtube_fetcher_workflow_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_project_iam_member" "youtube_fetcher_workflow_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

// Cloud Storage IAM Bindings
resource "google_storage_bucket_iam_member" "youtube_fetcher_cache_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_functions.email}"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_metadata_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_functions.email}"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_public_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_public.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_functions.email}"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_cache_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_metadata_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_public_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_public.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}
