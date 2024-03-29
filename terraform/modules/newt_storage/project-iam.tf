resource "google_project_iam_member" "eventarc_eventreceiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.eventarc.email}"
}

resource "google_project_iam_member" "eventarc_workflows_invoker" {
  project = var.project_id
  role    = "roles/workflows.invoker"
  member  = "serviceAccount:${google_service_account.eventarc.email}"
}

resource "google_project_iam_member" "gcp_sa_pubsub_tokencreator" {
  project = data.google_project.project.id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-${data.google_project.main.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "gs_project_accounts_pubsub_publisher" {
  project = data.google_project.project.id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.main.number}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "workflow_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}

resource "google_project_iam_member" "workflow_logwriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}
