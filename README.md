# www.kaito.tokyo

## Google Cloud

### Bootstrap

```
PROJECT_ID=www-kaito-tokyo
SERVICE_ACCOUNT_NAME=infra-manager-bootstrap
gcloud config set project $PROJECT_ID
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
```

```
gcloud infra-manager deployments apply \
  projects/www-kaito-tokyo/locations/asia-east1/deployments/wif-github-umireon \
  --git-source-repo="https://github.com/umireon/www.kaito.tokyo.git" \
  --git-source-directory="modules/wif-github-umireon" \
  --git-source-ref="main" \
  --service-account="projects/www-kaito-tokyo/serviceAccounts/$SERVICE_ACCOUNT_NAME@www-kaito-tokyo.iam.gserviceaccount.com" \
  --input-values="project_id=www-kaito-tokyo"
```
