locals {
  endpoints = {
    "digest"                      = google_cloudfunctions2_function.digest.service_config[0].uri,
    "save_search_list"            = google_cloudfunctions2_function.save_search_list.service_config[0].uri,
    "split_search_list"           = google_cloudfunctions2_function.split_search_list.service_config[0].uri,
    "generate_video_list_queries" = google_cloudfunctions2_function.generate_video_list_queries.service_config[0].uri,
    "save_video_list"             = google_cloudfunctions2_function.save_video_list.service_config[0].uri,
    "split_video_list"            = google_cloudfunctions2_function.split_video_list.service_config[0].uri,
    "compose_video_list"          = google_cloudfunctions2_function.compose_video_list.service_config[0].uri
  }
  channel_id = "UCfhyVWrxCmdUpst-5n7Kz_Q"
}

resource "google_workflows_workflow" "fetch_latest_search_list" {
  name            = "youtube-fetcher-fetch-latest-search-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
  user_env_vars = {
    "ENDPOINTS"            = jsonencode(local.endpoints)
    "CHANNEL_ID"           = local.channel_id
    "CACHE_BUCKET_NAME"    = google_storage_bucket.cache.name
    "METADATA_BUCKET_NAME" = google_storage_bucket.metadata.name
  }
}

resource "google_workflows_workflow" "fetch_all_search_list" {
  name            = "youtube-fetcher-fetch-all-search-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
  user_env_vars = {
    "ENDPOINTS"            = jsonencode(local.endpoints)
    "CHANNEL_ID"           = local.channel_id
    "CACHE_BUCKET_NAME"    = google_storage_bucket.cache.name
    "METADATA_BUCKET_NAME" = google_storage_bucket.metadata.name
  }
}

resource "google_workflows_workflow" "fetch_all_video_list" {
  name            = "youtube-fetcher-fetch-all-video-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-video-list.yaml")
  user_env_vars = {
    "ENDPOINTS"            = jsonencode(local.endpoints)
    "CHANNEL_ID"           = local.channel_id
    "CACHE_BUCKET_NAME"    = google_storage_bucket.cache.name
    "METADATA_BUCKET_NAME" = google_storage_bucket.metadata.name
  }
}
