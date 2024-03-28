resource "google_storage_bucket_iam_member" "allusers_www_kaito_tokyo_object_viewer" {
  bucket = google_storage_bucket.www_kaito_tokyo.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "newt_www_kaito_tokyo_www_kaito_tokyo_object_user" {
  bucket = google_storage_bucket.www_kaito_tokyo.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.newt_www_kaito_tokyo.email}"
}

resource "google_storage_bucket_iam_member" "functions_www_kaito_tokyo_object_user" {
  bucket = google_storage_bucket.www_kaito_tokyo.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.function.email}"
}
