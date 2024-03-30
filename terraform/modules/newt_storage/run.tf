resource "google_cloud_run_v2_service" "optimize_image" {
  name     = "newt-storage-optimize-image"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
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
    containers {
      image = var.run_image
      args  = ["--", "--target=newt-storage-optimize-image"]
    }
  }
}
