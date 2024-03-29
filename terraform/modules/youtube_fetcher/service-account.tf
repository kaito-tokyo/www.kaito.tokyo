resource "google_service_account" "workflow" {
  account_id = "yf-workflow"
}

resource "google_service_account" "function" {
  account_id = "yf-function"
}
