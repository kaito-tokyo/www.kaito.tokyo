locals {
  env = "prod1"
}

module "youtube_fetcher" {
  source     = "../../modules/youtube_fetcher"
  project_id = var.project_id
}
