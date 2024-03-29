resource "google_service_account" "newt_www_kaito_tokyo" {
  account_id = "ns-newt-www-kaito-tokyo"
}

resource "google_service_account" "workflow" {
  account_id = "ns-workflow"
}

resource "google_service_account" "function" {
  account_id = "ns-function"
}

resource "google_service_account" "eventarc" {
  account_id = "ns-eventarc"
}
