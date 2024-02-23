resource "google_storage_bucket" "www_kaito_tokyo" {
  name                        = "${var.project_id}-newt-storage-www-kaito-tokyo"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}
