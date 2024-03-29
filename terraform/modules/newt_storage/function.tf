data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "${path.module}/../../.."
  excludes    = [".cloudbuild", ".git", ".github", "terraform", "README.md"]
  output_path = "${var.tmp_dir}/function-source-newt-storage.zip"
}

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source-newt-storage.zip"
  bucket = google_storage_bucket.function_source.name
  source = data.archive_file.function_source.output_path
}

resource "google_cloudfunctions2_function" "optimize_image" {
  name     = "newt-storage-optimize-image"
  location = "asia-east1"

  build_config {
    entry_point = "newt-storage-optimize-image"
    runtime     = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    available_memory      = "1024M"
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "upload_object_to_cdn" {
  name     = "newt-storage-upload-object-to-cdn"
  location = "asia-east1"

  build_config {
    entry_point = "newt-storage-upload-object-to-cdn"
    runtime     = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    environment_variables = {
      CDN_REGION                        = var.cdn_region
      CDN_ENDPOINT                      = var.cdn_endpoint
      CDN_BUCKET_NAME                   = var.cdn_bucket_name
      CDN_ACCESS_KEY_ID_SECRET_NAME     = google_secret_manager_secret.cdn_access_key_id.name
      CDN_SECRET_ACCESS_KEY_SECRET_NAME = google_secret_manager_secret.cdn_secret_access_key.name
    }
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}
