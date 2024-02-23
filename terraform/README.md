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
gcloud services enable iam.googleapis.com
```

Add a connection for GitHub on Cloud Build first.

```
PROJECT_ID=www-kaito-tokyo-1-svc-my1a
SERVICE_ACCOUNT_NAME=cloudbuild-terraform-main
TRIGGER_NAME=terraform-main
WORKFLOW_PATH=".cloudbuild/workflows/$TRIGGER_NAME.yaml"
REPOSITORY="projects/$PROJECT_ID/locations/asia-east1/connections/kaito-tokyo/repositories/kaito-tokyo-www.kaito.tokyo"

gcloud iam service-accounts create "$SERVICE_ACCOUNT_NAME"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/owner \
  --condition=None

gcloud storage buckets add-iam-policy-binding gs://$PROJECT_ID-tfstate \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/storage.objectAdmin \
  --condition=None

gcloud builds triggers create github \
  --name="$TRIGGER_NAME" \
  --region=asia-east1 \
  --repository="$REPOSITORY" \
  --branch-pattern="^main$" \
  --build-config="$WORKFLOW_PATH" \
  --service-account=projects/$PROJECT_ID/serviceAccounts/$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com \
  --include-logs-with-status
```

# Enable APIs required for Terraform

```
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable workflows.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable youtube.googleapis.com
gcloud services enable eventarc.googleapis.com
```
