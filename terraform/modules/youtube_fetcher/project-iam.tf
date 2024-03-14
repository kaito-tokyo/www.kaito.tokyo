resource "google_project_iam_member" "workflow_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_project_iam_member" "workflow_logwriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_project_iam_member" "workflow_cb_main_logwriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.workflow_cb_main.email}"
}

resource "google_project_iam_member" "workflow_cb_main_functions_admin" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.workflow_cb_main.email}"
}

resource "google_project_iam_member" "workflow_cb_main_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.workflow_cb_main.email}"
}

resource "google_project_iam_member" "workflow_cb_main_workflows_admin" {
  project = var.project_id
  role    = "roles/workflows.admin"
  member  = "serviceAccount:${google_service_account.workflow_cb_main.email}"
}
