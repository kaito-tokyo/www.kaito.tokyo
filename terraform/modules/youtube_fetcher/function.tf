data "archive_file" "function_source" {
  type       = "zip"
  source_dir = "${path.module}/../../.."
  excludes = [
    "terraform"
  ]
  output_path = "${var.tmp_dir}/function-source.zip"
}

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.function_source.name
  source = data.archive_file.function_source.output_path
}
