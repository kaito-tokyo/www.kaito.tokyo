project_id                    = "www-kaito-tokyo-1-svc-my1a"
cloudbuild_trigger_repository = "projects/www-kaito-tokyo-1-svc-my1a/locations/asia-east1/connections/kaito-tokyo/repositories/kaito-tokyo-www.kaito.tokyo"
cdn_region                    = "auto"
cdn_endpoint                  = "https://1169b990c0885e4cfa603c38eef1a9b3.r2.cloudflarestorage.com"
cdn_bucket_name               = "www-img-kaito-tokyo"

youtube_fetcher_channel_ids = [
  "UCfhyVWrxCmdUpst-5n7Kz_Q", # umireon
]
youtube_fetcher_playlist_ids = [
  "PLfd4SnaQQz_BiGR_gWC2OnYUb8NlJ1odU", # PTCGL
  "PLfd4SnaQQz_ABlf7TdX-6YLA1XhPoZ4Zi", # お絵描き
]
youtube_fetcher_principalset_publish_image_gha_main   = "principalSet://iam.googleapis.com/projects/643615470006/locations/global/workloadIdentityPools/github-kaito-tokyo/attribute.repo_ref_workflow/repo:kaito-tokyo/www.kaito.tokyo:ref:refs/heads/main:workflow:image-publish-main"
youtube_fetcher_principalset_apply_terraform_gha_main = "principalSet://iam.googleapis.com/projects/643615470006/locations/global/workloadIdentityPools/github-kaito-tokyo/attribute.repo_ref_workflow/repo:kaito-tokyo/www.kaito.tokyo:ref:refs/heads/main:workflow:apply-terraform-main"
