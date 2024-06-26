module "newt_storage" {
  source     = "../../modules/newt_storage"
  project_id = var.project_id
  region     = var.region

  newt_storage_cdn_region                 = var.newt_storage_cdn_region
  newt_storage_cdn_bucket_name            = var.newt_storage_cdn_bucket_name
  newt_storage_cdn_endpoint               = var.newt_storage_cdn_endpoint
  newt_storage_principalset_push_gha_main = var.newt_storage_principalset_push_gha_main

  run_image = var.run_image
}

module "youtube_fetcher" {
  source     = "../../modules/youtube_fetcher"
  project_id = var.project_id
  region     = var.region

  youtube_fetcher_channel_ids                = var.youtube_fetcher_channel_ids
  youtube_fetcher_playlist_ids               = var.youtube_fetcher_playlist_ids
  youtube_fetcher_principalset_push_gha_main = var.youtube_fetcher_principalset_push_gha_main

  run_image = var.run_image
}
