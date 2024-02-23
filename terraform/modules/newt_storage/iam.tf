resource "google_project_iam_member" "functions_cb_main_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.functions_cb_main.email}"
}

resource "google_project_iam_member" "functions_cb_main_functions_admin" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.functions_cb_main.email}"
}

resource "google_project_iam_member" "functions_cb_main_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.functions_cb_main.email}"
}
