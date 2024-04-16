resource "google_storage_bucket_iam_member" "allusers_www_kaito_tokyo_objectviewer" {
  bucket = google_storage_bucket.www_kaito_tokyo.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "newt_www_kaito_tokyo_input_www_kaito_tokyo_objectuser" {
  bucket = google_storage_bucket.input_www_kaito_tokyo.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.newt_www_kaito_tokyo.email}"
}

resource "google_storage_bucket_iam_member" "run_input_www_kaito_tokyo_objectviewer" {
  bucket = google_storage_bucket.input_www_kaito_tokyo.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.run.email}"
}

resource "google_storage_bucket_iam_member" "run_optimized_www_kaito_tokyo_objectuser" {
  bucket = google_storage_bucket.optimized_www_kaito_tokyo.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.run.email}"
}
