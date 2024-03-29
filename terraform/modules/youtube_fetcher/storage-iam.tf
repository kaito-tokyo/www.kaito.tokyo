resource "google_storage_bucket_iam_member" "functions_cache_objectuser" {
  bucket = google_storage_bucket.cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.function.email}"
}

resource "google_storage_bucket_iam_member" "functions_metadata_objectuser" {
  bucket = google_storage_bucket.metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.function.email}"
}

resource "google_storage_bucket_iam_member" "functions_public_objectuser" {
  bucket = google_storage_bucket.public.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.function.email}"
}

resource "google_storage_bucket_iam_member" "allusers_public_viewer" {
  bucket = google_storage_bucket.public.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "workflow_cache_objectuser" {
  bucket = google_storage_bucket.cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_storage_bucket_iam_member" "workflow_metadata_objectuser" {
  bucket = google_storage_bucket.metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_storage_bucket_iam_member" "workflow_public_objectuser" {
  bucket = google_storage_bucket.public.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.workflow.email}"
}
