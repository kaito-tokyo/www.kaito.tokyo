resource "google_service_account_iam_member" "functions_cb_main_service_account_user" {
  service_account_id = google_service_account.functions.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.functions_cb_main.email}"
}
