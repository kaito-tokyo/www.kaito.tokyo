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
      var.youtube_fetcher_principalset_publish_image_gha_main,
    ]
  }
}

resource "google_service_account_iam_policy" "publish_image_gha_main" {
  service_account_id = google_service_account.publish_image_gha_main.name
  policy_data        = data.google_iam_policy.service_account_publish_image_gha_main_iam.policy_data
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
  location    = google_artifact_registry_repository.main.location
  policy_data = data.google_iam_policy.artifact_registry_main_iam.policy_data
}

resource "google_service_account" "apply_terraform_gha_main" {
  description = "Service account to apply terraform"
  account_id  = "${var.namespace_short}-apply-terraform-gha-main"
}

resource "google_project_iam_member" "apply_terraform_gha_main_owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.apply_terraform_gha_main.email}"
}

data "google_iam_policy" "service_account_apply_terraform_gha_main_iam" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      var.youtube_fetcher_principalset_apply_terraform_gha_main,
    ]
  }
}

resource "google_service_account_iam_policy" "apply_terraform_gha_main" {
  service_account_id = google_service_account.apply_terraform_gha_main.name
  policy_data        = data.google_iam_policy.service_account_apply_terraform_gha_main_iam.policy_data
}

resource "terraform_data" "bootstrap" {
  depends_on = [
    google_service_account_iam_policy.apply_terraform_gha_main,
    google_project_iam_member.apply_terraform_gha_main_owner,
    google_artifact_registry_repository_iam_policy.main,
    google_service_account_iam_policy.publish_image_gha_main,
  ]
}
