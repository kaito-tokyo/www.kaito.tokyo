variable "project_id" {
  description = "project id"
  type        = string
}

variable "cloudbuild_trigger_repository" {
  description = "cloudbuild trigger repository"
  type        = string
}

variable "channel_ids" {
  description = "list of channel ids to fetch"
  type        = list(string)
}

variable "playlist_ids" {
  description = "list of playlist ids to fetch"
  type        = list(string)
}

variable "region" {
  description = "region of the cloud services"
  type        = string
}

variable "run_image" {
  description = "image to run the cloud run service"
  type        = string
}

variable "namespace_short" {
  description = "value of the namespace label"
  type        = string
  default     = "yf"
}
