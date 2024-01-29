resource "google_service_account" "youtube_video_fetcher" {
  project    = var.project_id
  account_id = "youtube-video-fetcher"
}
