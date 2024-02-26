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
