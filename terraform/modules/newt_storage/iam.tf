// Cloud Storage IAM Bindings
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