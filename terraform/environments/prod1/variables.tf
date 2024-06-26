// Common
variable "cloudbuild_trigger_repository" {
  type = string
}

variable "project_id" {
  description = "project id"
  type        = string
}

variable "region" {
  description = "region of the cloud services"
  type        = string
}

// Newt Storage
variable "cdn_region" {
  type = string
}

variable "cdn_endpoint" {
  type = string
}

variable "cdn_bucket_name" {
  type = string
}

// Newt Storage
variable "newt_storage_cdn_bucket_name" {
  description = "name of the bucket"
  type        = string
}

variable "newt_storage_cdn_endpoint" {
  description = "endpoint of the CDN"
  type        = string
}

variable "newt_storage_cdn_region" {
  description = "region of the CDN"
  type        = string
}

variable "newt_storage_principalset_push_gha_main" {
  description = "principal set for the service account to deploy the infra"
  type        = string
}

// YouTube Fetcher
variable "youtube_fetcher_channel_ids" {
  description = "list of channel ids to fetch"
  type        = list(string)
}

variable "youtube_fetcher_playlist_ids" {
  description = "list of playlist ids to fetch"
  type        = list(string)
}

variable "youtube_fetcher_principalset_push_gha_main" {
  description = "principal set for the service account to deploy the infra"
  type        = string
}

// Determined every build
variable "run_image" {
  description = "image to run the cloud run service"
  type        = string
}
