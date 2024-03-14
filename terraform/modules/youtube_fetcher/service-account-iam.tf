resource "google_service_account_iam_member" "workflow_cb_main_function_serviceaccountuser" {
  service_account_id = google_service_account.function.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.workflow_cb_main.email}"
}

resource "google_service_account_iam_member" "workflows_cb_main_workflow_serviceaccountuser" {
  service_account_id = google_service_account.workflow.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.workflow_cb_main.email}"
}
