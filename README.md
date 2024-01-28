# www.kaito.tokyo

## Google Cloud

### Bootstrap

```
PROJECT_ID=www-kaito-tokyo
SERVICE_ACCOUNT_NAME=infra-manager-bootstrap
gcloud config set project $PROJECT_ID
PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")
REGION=asia-east1
POOL_ID=github-umireon
```

```
gcloud services enable config.googleapis.com
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/config.agent
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/iam.workloadIdentityPoolAdmin
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/iam.serviceAccountAdmin
```

```
gcloud infra-manager deployments apply \
  "projects/$PROJECT_ID/locations/$REGION/deployments/wif-github-umireon" \
  --git-source-repo="https://github.com/umireon/www.kaito.tokyo.git" \
  --git-source-directory="modules/wif-github-umireon" \
  --git-source-ref="main" \
  --service-account="projects/$PROJECT_ID/serviceAccounts/$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --input-values="project_id=$PROJECT_ID"
```

```
gcloud infra-manager deployments apply \
  "projects/$PROJECT_ID/locations/$REGION/deployments/wif-gha-www-kaito-tokyo" \
  --git-source-repo="https://github.com/umireon/www.kaito.tokyo.git" \
  --git-source-directory="modules/wif-gha-www-kaito-tokyo" \
  --git-source-ref="main" \
  --service-account="projects/$PROJECT_ID/serviceAccounts/$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --input-values="project_id=$PROJECT_ID,project_number=$PROJECT_NUMBER,pool_id=$POOL_ID"
```
