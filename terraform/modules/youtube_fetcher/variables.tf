variable "project_id" {
  description = "project id"
  type        = string
}

variable "region" {
  description = "region of the cloud services"
  type        = string
}

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

variable "newt_storage_run_image" {
  description = "image to run the cloud run service"
  type        = string
}

variable "namespace_short" {
  description = "value of the namespace label"
  type        = string
  default     = "yf"
}
