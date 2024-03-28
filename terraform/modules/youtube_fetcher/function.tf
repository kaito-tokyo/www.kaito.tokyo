data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "${path.module}/../../.."
  excludes    = [".git"]
  output_path = "${var.tmp_dir}/function-source-youtube-fetcher.zip"
}

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source-youtube-fetcher.zip"
  bucket = google_storage_bucket.function_source.name
  source = data.archive_file.function_source.output_path
}

resource "google_cloudfunctions2_function" "digest" {
  name     = "youtube-fetcher-digest"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}