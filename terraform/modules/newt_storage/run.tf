resource "google_cloud_run_v2_service" "optimize_image" {
  name     = "newt-storage-optimize-image"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=newt-storage-optimize-image"]

      resources {
        limits = {
          memory = "1024Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_service" "upload_object_to_cdn" {
  name     = "newt-storage-upload-object-to-cdn"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=newt-storage-upload-object-to-cdn"]

      env {
        name  = "CDN_REGION"
        value = var.cdn_region
      }

      env {
        name  = "CDN_REGION"
        value = var.cdn_region
      }

      env {
        name  = "CDN_ENDPOINT"
        value = var.cdn_endpoint
      }

      env {
        name  = "CDN_BUCKET_NAME"
        value = var.cdn_bucket_name
      }

      env {
        name  = "CDN_ACCESS_KEY_ID_SECRET_NAME"
        value = google_secret_manager_secret.cdn_access_key_id.name
      }

      env {
        name  = "CDN_SECRET_ACCESS_KEY_SECRET_NAME"
        value = google_secret_manager_secret.cdn_secret_access_key.name
      }
    }
  }
}
