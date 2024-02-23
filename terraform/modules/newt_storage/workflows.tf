locals {
  workflow_env_vars = {
    BUCKET_NAME = google_storage_bucket.newt_storage_www_kaito_tokyo.name
  }
}

resource "google_workflows_workflow" "optimize_and_upload_image" {
  name            = "newt-storage-optimize-and-upload-image"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/optimize-and-upload-image.yaml")
}
