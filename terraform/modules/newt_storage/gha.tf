resource "google_artifact_registry_repository" "main" {
  repository_id = "${var.namespace_short}-main"
  location      = var.region
  format        = "DOCKER"
}

resource "google_service_account" "push_gha_main" {
  description = "Service account to deploy the infrastructure"
  account_id  = "${var.namespace_short}-push-gha-main"
}

resource "google_project_iam_member" "push_gha_main_owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.push_gha_main.email}"
}

data "google_iam_policy" "service_account_push_gha_main_iam" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      var.newt_storage_principalset_push_gha_main,
    ]
  }
}

resource "google_service_account_iam_policy" "push_gha_main" {
  service_account_id = google_service_account.push_gha_main.name
  policy_data        = data.google_iam_policy.service_account_push_gha_main_iam.policy_data
}

