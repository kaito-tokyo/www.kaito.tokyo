resource "google_artifact_registry_repository" "main" {
  repository_id = "${var.namespace_short}-main"
  location      = var.region
  format        = "DOCKER"
}

resource "google_service_account" "publish_image_gha_main" {
  description = "Service account to publish image to GCR"
  account_id  = "${var.namespace_short}-publish-image-gha-main"
}

data "google_iam_policy" "service_account_publish_image_gha_main_iam" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      var.principalset_publish_image_gha_main,
    ]
  }
}

resource "google_service_account_iam_policy" "main" {
  service_account_id = google_service_account.publish_image_gha_main.email
  policy_data        = data.google_iam_policy.artifact_registry_main_iam.policy_data
}

data "google_iam_policy" "artifact_registry_main_iam" {
  binding {
    role = "roles/artifactregistry.writer"
    members = [
      "serviceAccount:${google_service_account.publish_image_gha_main.email}",
    ]
  }
}

resource "google_artifact_registry_repository_iam_policy" "main" {
  repository  = google_artifact_registry_repository.main.name
  policy_data = data.google_iam_policy.artifact_registry_main_iam.policy_data
}
