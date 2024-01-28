resource "google_iam_workload_identity_pool" "github_umireon" {
  project                   = var.project_id
  workload_identity_pool_id = "github-umireon"
}

resource "google_iam_workload_identity_pool_provider" "github_umireon" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_umireon.workload_identity_pool_id
  workload_identity_pool_provider_id = "actions-githubusercontent-com"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    allowed_audiences = ["https://github.com/umireon"]
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
}
