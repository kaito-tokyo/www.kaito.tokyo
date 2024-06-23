module "youtube_fetcher" {
  source     = "../../modules/youtube_fetcher"
  project_id = var.project_id
  region     = var.region

  youtube_fetcher_channel_ids                           = var.youtube_fetcher_channel_ids
  youtube_fetcher_playlist_ids                          = var.youtube_fetcher_playlist_ids
  youtube_fetcher_principalset_apply_terraform_gha_main = var.youtube_fetcher_principalset_apply_terraform_gha_main
  youtube_fetcher_principalset_publish_image_gha_main   = var.youtube_fetcher_principalset_publish_image_gha_main

  run_image = var.run_image
}

module "newt_storage" {
  source                        = "../../modules/newt_storage"
  project_id                    = var.project_id
  cloudbuild_trigger_repository = var.cloudbuild_trigger_repository
  run_image                     = var.run_image
  cdn_region                    = var.cdn_region
  cdn_endpoint                  = var.cdn_endpoint
  cdn_bucket_name               = var.cdn_bucket_name
}
