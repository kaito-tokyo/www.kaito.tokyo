variable "project_id" {
  description = "project id"
  type        = string
}

variable "region" {
  description = "region of the cloud services"
  type        = string
}

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

variable "run_image" {
  description = "image to run the cloud run service"
  type        = string
}

variable "namespace_short" {
  description = "value of the namespace label"
  type        = string
  default     = "ns"
}
