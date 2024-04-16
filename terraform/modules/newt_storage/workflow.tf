locals {
  endpoints = {
    optimizeImage     = google_cloud_run_v2_service.optimize_image.uri,
    uploadObjectToCdn = google_cloud_run_v2_service.upload_object_to_cdn.uri,
  }
  buckets = {
    optimized = google_storage_bucket.optimized_www_kaito_tokyo.name,
  }
}

resource "google_workflows_workflow" "optimize_and_upload_image" {
  name            = "newt-storage-optimize-and-upload-image"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  user_env_vars = {
    BUCKETS   = jsonencode(local.buckets),
    ENDPOINTS = jsonencode(local.endpoints),
  }
  source_contents = file("${path.module}/workflows/optimize-and-upload-image.yaml")
}
