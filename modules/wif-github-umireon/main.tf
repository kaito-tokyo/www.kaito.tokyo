resource "google_iam_workload_identity_pool" "github_umireon" {
  project                   = var.project_id
  workload_identity_pool_id = "github-umireon"
}

resource "google_iam_workload_identity_pool_provider" "github_umireon" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_umireon.workload_identity_pool_id
  workload_identity_pool_provider_id = "actions-githubusercontent-com"
  attribute_condition                = "assertion.repository_owner == \"umireon\""
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository_owner" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
