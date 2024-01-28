resource "google_service_account" "gha_www_kaito_tokyo" {
  project    = var.project_id
  account_id = "gha-www-kaito-tokyo"
}

data "google_iam_policy" "gha_www_kaito_tokyo" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${var.pool_id}/attribute.ATTRIBUTE_NAME/ATTRIBUTE_VALUE"
    ]
  }
}

resource "google_service_account_iam_policy" "gha_www_kaito_tokyo" {
  service_account_id = google_service_accountcd.gha_www_kaito_tokyo.name
  policy_data        = data.google_iam_policy.gha_www_kaito_tokyo.policy_data
}
