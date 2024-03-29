resource "google_eventarc_trigger" "optimize_and_upload_image_www_kaito_tokyo" {
  name     = "optimize-and-upload-image-www-kaito-tokyo"
  location = "asia-east1"

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }

  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.www_kaito_tokyo.name
  }

  destination {
    workflow = google_workflows_workflow.optimize_and_upload_image.id
  }

  service_account = google_service_account.eventarc.email
}
