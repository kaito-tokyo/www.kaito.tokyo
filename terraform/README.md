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
CB_SERVICE_ACCOUNT_NAME=wkt-terraform-cb-main
TRIGGER_NAME=www-kaito-tokyo-terraform-main
WORKFLOW_PATH=".cloudbuild/workflows/$TRIGGER_NAME.yaml"
REPOSITORY="projects/$PROJECT_ID/locations/asia-east1/connections/kaito-tokyo/repositories/kaito-tokyo-www.kaito.tokyo"

gcloud iam service-accounts create "$CB_SERVICE_ACCOUNT_NAME"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$CB_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/owner \
  --condition=None

gcloud storage buckets add-iam-policy-binding gs://$PROJECT_ID-tfstate \
  --member="serviceAccount:$CB_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/storage.objectAdmin \
  --condition=None

gcloud builds triggers create github \
  --name="$TRIGGER_NAME" \
  --region=asia-east1 \
  --repository="$REPOSITORY" \
  --branch-pattern="^main$" \
  --build-config="$WORKFLOW_PATH" \
  --service-account=projects/$PROJECT_ID/serviceAccounts/$CB_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com \
  --include-logs-with-status
```

```
GHA_SERVICE_ACCOUNT_NAME=wkt-terraform-gha-pr
GHA_PRINCIPALSET=principalSet://iam.googleapis.com/projects/643615470006/locations/global/workloadIdentityPools/github-kaito-tokyo/attribute.repository/kaito-tokyo/www.kaito.tokyo

gcloud iam service-accounts create "$GHA_SERVICE_ACCOUNT_NAME"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$GHA_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/viewer \
  --condition=None

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$GHA_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/storage.insightsCollectorService \
  --condition=None

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$GHA_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/iam.securityReviewer \
  --condition=None

gcloud storage buckets add-iam-policy-binding gs://$PROJECT_ID-tfstate \
  --member="serviceAccount:$GHA_SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/storage.objectViewer \
  --condition=None
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
