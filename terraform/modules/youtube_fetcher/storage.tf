resource "google_storage_bucket" "cache" {
  name                        = "${var.project_id}-youtube-fetcher-cache"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "metadata" {
  name                        = "${var.project_id}-youtube-fetcher-metadata"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "public" {
  name                        = "${var.project_id}-youtube-fetcher-public"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}
