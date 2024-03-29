resource "google_cloudfunctions2_function_iam_member" "workflow_optimize_image_run_invoker" {
  cloud_function = google_cloudfunctions2_function.optimize_image.name
  role           = "roles/run.invoker"
  member         = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloudfunctions2_function_iam_member" "workflow_upload_object_to_cdn_run_invoker" {
  cloud_function = google_cloudfunctions2_function.upload_object_to_cdn.name
  role           = "roles/run.invoker"
  member         = "serviceAccount:${google_service_account.workflow.email}"
}
