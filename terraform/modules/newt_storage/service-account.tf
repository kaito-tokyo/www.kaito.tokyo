resource "google_service_account" "newt_storage_www_kaito_tokyo" {
  project    = var.project_id
  account_id = "newt-storage-www-kaito-tokyo"
}

resource "google_service_account" "workflow" {
  project    = var.project_id
  account_id = "ns-workflow"
}