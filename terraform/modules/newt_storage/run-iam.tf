resource "google_cloud_run_service_iam_member" "workflow_optimize_image_run_invoker" {
  location = google_cloud_run_v2_service.optimize_image.location
  service  = google_cloud_run_v2_service.optimize_image.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_upload_object_to_cdn_run_invoker" {
  location = google_cloud_run_v2_service.upload_object_to_cdn.location
  service  = google_cloud_run_v2_service.upload_object_to_cdn.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}
