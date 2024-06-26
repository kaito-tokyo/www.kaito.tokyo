resource "google_service_account" "run" {
  description = "Service account for Cloud Run service"
  account_id  = "${var.namespace_short}-run"
}

resource "google_secret_manager_secret" "cdn_access_key_id" {
  secret_id = "cdn-access-key-id"

  replication {
    user_managed {
      replicas {
        location = "asia-east1"
      }
    }
  }
}

resource "google_secret_manager_secret" "cdn_secret_access_key" {
  secret_id = "cdn-secret-access-key"

  replication {
    user_managed {
      replicas {
        location = "asia-east1"
      }
    }
  }
}

data "google_iam_policy" "run_secret_iam" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = [
      "serviceAccount:${google_service_account.run.email}",
    ]
  }
}

resource "google_secret_manager_secret_iam_policy" "cdn_access_key_id" {
  secret_id   = google_secret_manager_secret.cdn_access_key_id.secret_id
  policy_data = data.google_iam_policy.run_secret_iam.policy_data
}

resource "google_secret_manager_secret_iam_policy" "cdn_secret_access_key" {
  secret_id   = google_secret_manager_secret.cdn_secret_access_key.secret_id
  policy_data = data.google_iam_policy.run_secret_iam.policy_data
}

resource "google_cloud_run_v2_service" "main" {
  name     = "${var.namespace_short}-main"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args = [
        "node",
        "packages/newt-storage/index.js"
      ]

      resources {
        limits = {
          memory = "1024Mi"
        }
      }

      env {
        name  = "CDN_REGION"
        value = var.newt_storage_cdn_region
      }

      env {
        name  = "CDN_ENDPOINT"
        value = var.newt_storage_cdn_endpoint
      }

      env {
        name  = "CDN_BUCKET_NAME"
        value = var.newt_storage_cdn_bucket_name
      }

      env {
        name  = "CDN_ACCESS_KEY_ID_SECRET_NAME"
        value = "${google_secret_manager_secret.cdn_access_key_id.name}/versions/latest"
      }

      env {
        name  = "CDN_SECRET_ACCESS_KEY_SECRET_NAME"
        value = "${google_secret_manager_secret.cdn_secret_access_key.name}/versions/latest"
      }
    }
  }
}

resource "google_service_account" "newt_www_kaito_tokyo" {
  description = "Service account for Newt"
  account_id  = "${var.namespace_short}-newt-www-kaito-tokyo"
}

resource "google_storage_bucket" "input_www_kaito_tokyo" {
  name                        = "${var.namespace_short}-input-www-kaito-tokyo-${var.project_id}"
  location                    = var.region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "optimized_www_kaito_tokyo" {
  name                        = "${var.namespace_short}-optimized-www-kaito-tokyo-${var.project_id}"
  location                    = var.region
  uniform_bucket_level_access = true
}

data "google_iam_policy" "bucket_input_iam" {
  binding {
    role = "roles/objectUser"
    members = [
      "serviceAccount:${google_service_account.newt_www_kaito_tokyo.email}",
      "serviceAccount:${google_service_account.run.email}",
    ]
  }

  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers",
      "serviceAccount:${google_service_account.run.email}",
    ]
  }

  binding {
    role = "roles/storage.admin"
    members = [
      "projectEditor:${var.project_id}",
      "projectOwner:${var.project_id}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "input_www_kaito_tokyo" {
  bucket      = google_storage_bucket.input_www_kaito_tokyo.name
  policy_data = data.google_iam_policy.bucket_input_iam.policy_data

}

data "google_iam_policy" "bucket_optimized_iam" {
  binding {
    role = "roles/storage.objectUser"
    members = [
      "serviceAccount:${google_service_account.run.email}",
    ]
  }

  binding {
    role = "roles/storage.admin"
    members = [
      "projectEditor:${var.project_id}",
      "projectOwner:${var.project_id}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "optimized_www_kaito_tokyo" {
  bucket      = google_storage_bucket.optimized_www_kaito_tokyo.name
  policy_data = data.google_iam_policy.bucket_optimized_iam.policy_data
}

resource "google_service_account" "workflow" {
  description = "Service account for Workflows"
  account_id  = "${var.namespace_short}-workflow"
}

data "google_iam_policy" "workflow_run_main" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.workflow.email}",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "main" {
  name        = google_cloud_run_v2_service.main.name
  location    = google_cloud_run_v2_service.main.location
  policy_data = data.google_iam_policy.workflow_run_main.policy_data
}

resource "google_project_iam_member" "workflow_logwriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}

locals {
  endpoints = {
    optimizeImage     = "${google_cloud_run_v2_service.main.uri}/optimize-image",
    uploadObjectToCdn = "${google_cloud_run_v2_service.main.uri}/upload-object-to-cdn",
  }
  buckets = {
    input     = google_storage_bucket.input_www_kaito_tokyo.name,
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

resource "google_workflows_workflow" "optimize_and_upload_all_images" {
  name            = "newt-storage-optimize-and-upload-all-images"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  user_env_vars = {
    BUCKETS   = jsonencode(local.buckets),
    ENDPOINTS = jsonencode(local.endpoints),
  }
  source_contents = file("${path.module}/workflows/optimize-and-upload-all-images.yaml")
}

resource "google_service_account" "eventarc" {
  description = "Service account for Eventarc trigger"
  account_id  = "${var.namespace_short}-eventarc"
}

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

resource "google_eventarc_trigger" "optimize_and_upload_input_image_www_kaito_tokyo" {
  name     = "optimize-and-upload-image-www-kaito-tokyo"
  location = var.region

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }

  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.input_www_kaito_tokyo.name
  }

  destination {
    workflow = google_workflows_workflow.optimize_and_upload_image.id
  }

  service_account = google_service_account.eventarc.email
}
