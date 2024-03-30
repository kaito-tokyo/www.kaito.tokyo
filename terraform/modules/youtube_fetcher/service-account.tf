resource "google_service_account" "workflow" {
  account_id = "yf-workflow"
}

resource "google_service_account" "run" {
  account_id = "yf-run"
}
