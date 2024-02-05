locals {
  channel_id = "UCfhyVWrxCmdUpst-5n7Kz_Q"
}

resource "google_service_account" "youtube_fetcher_workflow" {
  project    = var.project_id
  account_id = "youtube-fetcher-workflow"
}

resource "google_project_iam_member" "youtube_fetcher_workflow_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket" "youtube_fetcher_cache" {
  name                        = "www-kaito-tokyo-youtube-fetcher-cache"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_cache_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket" "youtube_fetcher_metadata" {
  name                        = "www-kaito-tokyo-youtube-fetcher-metadata"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_metadata_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

locals {
  workflow_constants = [
    {
      "Constants" = {
        "assign" = {
          "channelId"          = local.channel_id
          "cacheBucketName"    = google_storage_bucket.youtube_fetcher_cache.name
          "metadataBucketName" = google_storage_bucket.youtube_fetcher_metadata.name
        }
      }
    }
  ]
}

resource "google_workflows_workflow" "fetch_latest_video_metadata" {
  name            = "fetch-latest-video-metadata"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  source_contents = format(
    "%s\n%s",
    yamlencode(local.workflow_constants),
    file("${path.module}/workflows/fetch-latest-video-metadata.yaml")
  )
}

resource "google_service_account" "youtube_fetcher" {
  project    = var.project_id
  account_id = "youtube-fetcher"
}
