resource "google_storage_bucket_iam_member" "newt_storage_www_kaito_tokyo_allusers_viewer" {
  bucket = google_storage_bucket.newt_storage_www_kaito_tokyo.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "newt_storage_www_kaito_tokyo_object_user" {
  bucket = google_storage_bucket.newt_storage_www_kaito_tokyo.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.newt_storage_www_kaito_tokyo.email}"
}

// functions-cb-main
/// Project IAM Bindings
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

/// Service Account IAM Binfings
resource "google_service_account_iam_member" "functions_cb_main_service_account_user" {
  service_account_id = google_service_account.functions.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.functions_cb_main.email}"
}
