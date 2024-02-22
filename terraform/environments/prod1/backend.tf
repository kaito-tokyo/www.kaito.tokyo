terraform {
  backend "gcs" {
    bucket = "www-kaito-tokyo-1-svc-my1a-tfstate"
    prefix = "evnv/prod"
  }
}
