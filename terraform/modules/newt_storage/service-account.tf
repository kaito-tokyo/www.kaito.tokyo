resource "google_service_account" "newt_www_kaito_tokyo" {
  project    = var.project_id
  account_id = "ns-newt-www-kaito-tokyo"
}

resource "google_service_account" "workflow" {
  project    = var.project_id
  account_id = "ns-workflow"
}

resource "google_service_account" "function" {
  project    = var.project_id
  account_id = "ns-function"
}

resource "google_service_account" "eventarc" {
  project    = var.project_id
  account_id = "ns-eventarc"
}
