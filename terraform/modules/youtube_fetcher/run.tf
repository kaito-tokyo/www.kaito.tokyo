resource "google_cloud_run_v2_service" "youtube_fetcher_digest" {
  name     = "youtube-fetcher-digest"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-digest"]
    }
  }
}

resource "google_cloud_run_v2_service" "youtube_fetcher_save_search_list" {
  name     = "youtube-fetcher-save-search-list"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-save-search-list"]
    }
  }
}

resource "google_cloud_run_v2_service" "youtube_fetcher_split_search_list" {
  name     = "youtube-fetcher-split-search-list"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-split-search-list"]
    }
  }
}

resource "google_cloud_run_v2_service" "youtube_fetcher_generate_video_list_queries" {
  name     = "youtube-fetcher-generate-video-list-queries"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-generate-video-list-queries"]
    }
  }
}

resource "google_cloud_run_v2_service" "youtube_fetcher_save_video_list" {
  name     = "youtube-fetcher-save-video-list"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-save-video-list"]
    }
  }
}

resource "google_cloud_run_v2_service" "youtube_fetcher_split_video_list" {
  name     = "youtube-fetcher-split-video-list"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-split-video-list"]
    }
  }
}

resource "google_cloud_run_v2_service" "youtube_fetcher_compose_video_list" {
  name     = "youtube-fetcher-compose-video-list"
  location = "asia-east1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.run.email

    containers {
      image = var.run_image
      args  = ["--", "--target=youtube-fetcher-compose-video-list"]
    }
  }
}
