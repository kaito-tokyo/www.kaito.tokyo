resource "google_service_account" "newt_storage_www_kaito_tokyo" {
  project    = var.project_id
  account_id = "newt-storage-www-kaito-tokyo"
}

resource "google_service_account" "workflow" {
  project    = var.project_id
  account_id = "ns-workflow"
}

resource "google_service_account" "functions" {
  project    = var.project_id
  account_id = "ns-functions"
}

resource "google_service_account" "functions_cb_main" {
  project    = var.project_id
  account_id = "ns-functions-cb-main"
}
