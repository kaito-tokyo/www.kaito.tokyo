locals {
  env = "prod1"
}

module "youtube_fetcher" {
  source                        = "../../modules/youtube_fetcher"
  project_id                    = var.project_id
  cloudbuild_trigger_repository = var.cloudbuild_trigger_repository
}

module "newt_storage" {
  source     = "../../modules/newt_storage"
  project_id = var.project_id
}
