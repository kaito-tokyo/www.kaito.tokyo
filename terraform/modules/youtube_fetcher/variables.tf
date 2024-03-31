variable "project_id" {
  type = string
}

variable "cloudbuild_trigger_repository" {
  type = string
}

variable "run_image" {
  type = string
}
variable "channel_ids" {
  type = list(string)
}

variable "playlist_ids" {
  type = list(string)
}
