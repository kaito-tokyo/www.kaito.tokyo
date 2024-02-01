resource "google_service_account" "youtube_fetcher" {
  project    = var.project_id
  account_id = "youtube-fetcher"
}
