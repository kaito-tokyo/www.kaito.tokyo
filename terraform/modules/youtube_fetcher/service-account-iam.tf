resource "google_service_account_iam_member" "workflows_cb_main_serviceaccountuser" {
  service_account_id = google_service_account.functions.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.workflows_cb_main.email}"
}
