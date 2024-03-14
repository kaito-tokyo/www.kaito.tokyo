resource "google_service_account" "workflow" {
  project    = var.project_id
  account_id = "yf-workflow"
}

resource "google_service_account" "function" {
  project    = var.project_id
  account_id = "yf-function"
}

resource "google_service_account" "workflow_cb_main" {
  project    = var.project_id
  account_id = "yf-workflow-cb-main"
}
