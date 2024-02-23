resource "google_service_account" "workflow" {
  project    = var.project_id
  account_id = "yf-workflow"
}

resource "google_service_account" "functions" {
  project    = var.project_id
  account_id = "yf-functions"
}

resource "google_service_account" "functions_cb_main" {
  project    = var.project_id
  account_id = "yf-functions-cb-main"
}
