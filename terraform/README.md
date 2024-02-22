# The infrastructure codes of www.kaito.tokyo

## Setup

```
BUCKET_NAME=www-kaito-tokyo-1-svc-my1a-tfstate

gcloud storage buckets create "gs://$BUCKET_NAME" \
  --location=ASIA-EAST1 \
  --public-access-prevention \
  --uniform-bucket-level-access

gcloud storage buckets update "gs://$BUCKET_NAME" --versioning
```
