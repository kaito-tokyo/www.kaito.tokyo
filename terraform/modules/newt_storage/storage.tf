resource "google_storage_bucket" "input_www_kaito_tokyo" {
  name                        = "ns-input-www-kaito-tokyo-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "optimized_www_kaito_tokyo" {
  name                        = "ns-optimized-www-kaito-tokyo-${var.project_id}"
  location                    = "asia-east1"
  uniform_bucket_level_access = true
}
