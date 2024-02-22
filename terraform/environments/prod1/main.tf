locals {
  env = "prod1"
}

provider "google" {
  project = var.project_id
}

module "youtube_fetcher" {
  source     = "../../modules/youtube_fetcher"
  project_id = var.project_id
}
