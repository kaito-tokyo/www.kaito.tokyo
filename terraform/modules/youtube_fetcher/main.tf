resource "google_service_account" "run" {
  description = "Service account for Cloud Run"
  account_id  = "${var.namespace_short}-run"
}

resource "google_cloud_run_v2_service" "main" {
  name     = "${var.namespace_short}-main"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
    }
  }
}

resource "google_storage_bucket" "cache" {
  name                        = "${var.namespace_short}-cache-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "metadata" {
  name                        = "${var.namespace_short}-metadata-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "public" {
  name                        = "${var.namespace_short}-public-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "run_cache_objectuser" {
  bucket = google_storage_bucket.cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.run.email}"
}

resource "google_storage_bucket_iam_member" "run_metadata_objectuser" {
  bucket = google_storage_bucket.metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.run.email}"
}

resource "google_storage_bucket_iam_member" "run_public_objectuser" {
  bucket = google_storage_bucket.public.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.run.email}"
}

resource "google_storage_bucket_iam_member" "allusers_public_viewer" {
  bucket = google_storage_bucket.public.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

data "google_iam_policy" "bucket_cache_metadata_iam" {
  binding {
    role = "roles/storage.objectUser"
    members = [
      "serviceAccount:${google_service_account.run.email}",
      "serviceAccount:${google_service_account.workflow.email}",
    ]
  }

  binding {
    role = "roles/storage.legacyBucketOwner"
    members = [
      "projectEditor:${var.project_id}",
      "projectOwner:${var.project_id}",
    ]
  }

  binding {
    role = "roles/storage.legacyObjectOwner"
    members = [
      "projectEditor:${var.project_id}",
      "projectOwner:${var.project_id}",
    ]
  }

  binding {
    role = "roles/storage.legacyBucketReader"
    members = [
      "projectViewer:${var.project_id}",
    ]
  }

  binding {
    role = "roles/storage.legacyBucketReader"
    members = [
      "projectViewer:${var.project_id}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "workflow_cache_objectuser" {
  bucket      = google_storage_bucket.cache.name
  policy_data = data.google_iam_policy.bucket_cache_metadata_iam.policy_data
}

resource "google_storage_bucket_iam_policy" "workflow_metadata_objectuser" {
  bucket      = google_storage_bucket.metadata.name
  policy_data = data.google_iam_policy.bucket_cache_metadata_iam.policy_data
}

data "google_iam_policy" "bucket_public_iam" {
  binding {
    role = "roles/storage.objectUser"
    members = [
      "serviceAccount:${google_service_account.run.email}",
      "serviceAccount:${google_service_account.workflow.email}",
    ]
  }

  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers",
    ]
  }

  binding {
    role = "roles/storage.legacyBucketOwner"
    members = [
      "projectEditor:${var.project_id}",
      "projectOwner:${var.project_id}",
    ]
  }

  binding {
    role = "roles/storage.legacyObjectOwner"
    members = [
      "projectEditor:${var.project_id}",
      "projectOwner:${var.project_id}",
    ]
  }

  binding {
    role = "roles/storage.legacyBucketReader"
    members = [
      "projectViewer:${var.project_id}",
    ]
  }

  binding {
    role = "roles/storage.legacyBucketReader"
    members = [
      "projectViewer:${var.project_id}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "workflow_public_objectuser" {
  bucket      = google_storage_bucket.public.name
  policy_data = data.google_iam_policy.bucket_public_iam.policy_data
}

resource "google_service_account" "workflow" {
  account_id = "${var.namespace_short}-workflow"
}

resource "google_project_iam_member" "workflow_logwriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}

data "google_iam_policy" "workflow_workflow_main" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.workflow.email}",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "workflow_main_run_invoker" {
  service     = google_cloud_run_v2_service.main.name
  location    = google_cloud_run_v2_service.main.location
  policy_data = data.google_iam_policy.workflow_workflow_main.policy_data
}

locals {
  endpoints = {
    digest                   = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-digest"
    saveSearchList           = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-save-search-list"
    splitSearchList          = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-split-search-list"
    generateVideoListQueries = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-generate-video-list-queries"
    saveVideoList            = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-save-video-list"
    splitVideoList           = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-split-video-list"
    composeVideoList         = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-compose-video-list"
    savePlaylistItemsList    = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-save-playlist-items-list"
    composePlaylistItemsList = "${google_cloud_run_v2_service.main.uri}/youtube-fetcher-compose-playlist-items-list"
  }

  buckets = {
    cache    = google_storage_bucket.cache.name
    metadata = google_storage_bucket.metadata.name
    public   = google_storage_bucket.public.name
  }
}

resource "google_workflows_workflow" "fetch_latest_search_list" {
  name            = "youtube-fetcher-fetch-latest-search-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
  user_env_vars = {
    ENDPOINTS   = jsonencode(local.endpoints)
    BUCKETS     = jsonencode(local.buckets)
    CHANNEL_IDS = jsonencode(var.youtube_fetcher_channel_ids)
  }
}

resource "google_workflows_workflow" "fetch_all_search_list" {
  name            = "youtube-fetcher-fetch-all-search-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
  user_env_vars = {
    ENDPOINTS   = jsonencode(local.endpoints)
    BUCKETS     = jsonencode(local.buckets)
    CHANNEL_IDS = jsonencode(var.youtube_fetcher_channel_ids)
  }
}

resource "google_workflows_workflow" "fetch_all_video_list" {
  name            = "youtube-fetcher-fetch-all-video-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-video-list.yaml")
  user_env_vars = {
    ENDPOINTS   = jsonencode(local.endpoints)
    BUCKETS     = jsonencode(local.buckets)
    CHANNEL_IDS = jsonencode(var.youtube_fetcher_channel_ids)
  }
}

resource "google_workflows_workflow" "fetch_all_playlist_items_list" {
  name            = "youtube-fetcher-fetch-all-playlist-items-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-playlist-items-list.yaml")
  user_env_vars = {
    ENDPOINTS    = jsonencode(local.endpoints)
    BUCKETS      = jsonencode(local.buckets)
    PLAYLIST_IDS = jsonencode(var.youtube_fetcher_playlist_ids)
  }
}

