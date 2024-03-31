resource "google_storage_bucket" "cache" {
  name                        = "yf-cache-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "metadata" {
  name                        = "yf-metadata-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket" "public" {
  name                        = "yf-public-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "function_source" {
  name                        = "function-source-yf-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}
