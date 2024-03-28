resource "google_storage_bucket" "www_kaito_tokyo" {
  name                        = "${var.project_id}-newt-storage-www-kaito-tokyo"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "function_source" {
  project                     = var.project_id
  name                        = "function-source-ns-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}
