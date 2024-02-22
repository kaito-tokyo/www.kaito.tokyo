# The infrastructure codes of www.kaito.tokyo

## Setup tfstate storage

```
BUCKET_NAME=www-kaito-tokyo-1-svc-my1a-tfstate

gcloud storage buckets create "gs://$BUCKET_NAME" \
  --location=ASIA-EAST1 \
  --public-access-prevention \
  --uniform-bucket-level-access

gcloud storage buckets update "gs://$BUCKET_NAME" --versioning
```

## Setup Cloud Build for Terraform

```
gcloud services enable cloudbuild.googleapis.com
gcloud services enable secretmanager.googleapis.com
```

Add a connection for GitHub on Cloud Build first.

```
PROJECT_ID=www-kaito-tokyo-1-svc-my1a
SERVICE_ACCOUNT_NAME=cloudbuild-terraform-main

gcloud iam service-accounts create "$SERVICE_ACCOUNT_NAME"

gcloud project add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/logging.logWriter \
  --condition=None

gcloud builds triggers create github \
  --name=organization-terraform-main \
  --region=asia-east1 \
  --repository=projects/$PROJECT_ID/locations/asia-east1/connections/umireon/repositories/kaito-tokyo-www.kaito.tokyo \
  --branch-pattern="^main$" \
  --build-config=".cloudbuild/workflows/terraform-main.yaml" \
  --service-account=projects/$PROJECT_ID/serviceAccounts/cloudbuild-terraform-main@$PROJECT_ID.gserviceaccount.com \
  --include-logs-with-status
```
