resource "google_cloud_run_service_iam_member" "workflow_digest_run_invoker" {
  location = google_cloud_run_v2_service.digest.location
  service  = google_cloud_run_v2_service.digest.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_save_search_list_run_invoker" {
  location = google_cloud_run_v2_service.save_search_list.location
  service  = google_cloud_run_v2_service.save_search_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_split_search_list_run_invoker" {
  location = google_cloud_run_v2_service.split_search_list.location
  service  = google_cloud_run_v2_service.split_search_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_generate_video_list_queries_run_invoker" {
  location = google_cloud_run_v2_service.generate_video_list_queries.location
  service  = google_cloud_run_v2_service.generate_video_list_queries.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_save_video_list_run_invoker" {
  location = google_cloud_run_v2_service.save_video_list.location
  service  = google_cloud_run_v2_service.save_video_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_split_video_list_run_invoker" {
  location = google_cloud_run_v2_service.split_video_list.location
  service  = google_cloud_run_v2_service.split_video_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_cloud_run_service_iam_member" "workflow_compose_video_list_run_invoker" {
  location = google_cloud_run_v2_service.compose_video_list.location
  service  = google_cloud_run_v2_service.compose_video_list.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.workflow.email}"
}
