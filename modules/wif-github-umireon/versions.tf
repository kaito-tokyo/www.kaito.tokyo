terraform {
  required_version = "~> 1.7.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.13.0, < 6"
    }
  }
}
