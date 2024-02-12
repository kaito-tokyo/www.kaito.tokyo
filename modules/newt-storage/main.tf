// Service accounts
resource "google_service_account" "newt_storage_www_kaito_tokyo" {
  project    = var.project_id
  account_id = "newt-storage-www-kaito-tokyo"
}

// Cloud Storage Buckets
resource "google_storage_bucket" "newt_storage_www_kaito_tokyo" {
  name                        = "www-kaito-tokyo-newt-storage"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}

// Cloud Workflows
locals {
  workflow_env_vars = {
    CHANNEL_ID  = "UCfhyVWrxCmdUpst-5n7Kz_Q",
    BUCKET_NAME = google_storage_bucket.newt_storage_www_kaito_tokyo.name
  }
}

// Cloud Storage IAM Bindings
resource "google_storage_bucket_iam_member" "newt_storage_www_kaito_tokyo_allusers_viewer" {
  bucket = google_storage_bucket.newt_storage_www_kaito_tokyo.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "newt_storage_www_kaito_tokyo_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_cache.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.newt_storage_www_kaito_tokyo.email}"
}
