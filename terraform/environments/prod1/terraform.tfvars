project_id = "www-kaito-tokyo-1-svc-my1a"
region     = "asia-east1"

newt_storage_cdn_region                 = "auto"
newt_storage_cdn_endpoint               = "https://1169b990c0885e4cfa603c38eef1a9b3.r2.cloudflarestorage.com"
newt_storage_cdn_bucket_name            = "www-img-kaito-tokyo"
newt_storage_principalset_push_gha_main = "principalSet://iam.googleapis.com/projects/643615470006/locations/global/workloadIdentityPools/github-kaito-tokyo/attribute.repo_ref_workflow/repo:kaito-tokyo/www.kaito.tokyo:ref:refs/heads/main:workflow:push-main"

youtube_fetcher_channel_ids = [
  "UCfhyVWrxCmdUpst-5n7Kz_Q", # umireon
]
youtube_fetcher_playlist_ids = [
  "PLfd4SnaQQz_BiGR_gWC2OnYUb8NlJ1odU", # PTCGL
  "PLfd4SnaQQz_ABlf7TdX-6YLA1XhPoZ4Zi", # お絵描き
]
youtube_fetcher_principalset_push_gha_main = "principalSet://iam.googleapis.com/projects/643615470006/locations/global/workloadIdentityPools/github-kaito-tokyo/attribute.repo_ref_workflow/repo:kaito-tokyo/www.kaito.tokyo:ref:refs/heads/main:workflow:push-main"
