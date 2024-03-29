resource "google_cloud_run_service_iam_member" "workflow_digest_run_invoker" {
  location = google_cloudfunctions2_function.digest.location
  service  = google_cloudfunctions2_function.digest.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_save_search_list_run_invoker" {
  location = google_cloudfunctions2_function.save_search_list.location
  service  = google_cloudfunctions2_function.save_search_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_split_search_list_run_invoker" {
  location = google_cloudfunctions2_function.split_search_list.location
  service  = google_cloudfunctions2_function.split_search_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_generate_video_list_queries_run_invoker" {
  location = google_cloudfunctions2_function.generate_video_list_queries.location
  service  = google_cloudfunctions2_function.generate_video_list_queries.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_save_video_list_run_invoker" {
  location = google_cloudfunctions2_function.save_video_list.location
  service  = google_cloudfunctions2_function.save_video_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_split_video_list_run_invoker" {
  location = google_cloudfunctions2_function.split_video_list.location
  service  = google_cloudfunctions2_function.split_video_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_compose_video_list_run_invoker" {
  location = google_cloudfunctions2_function.compose_video_list.location
  service  = google_cloudfunctions2_function.compose_video_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}
