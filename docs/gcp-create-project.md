### Create GCP Project

-   https://cloud.google.com/community/tutorials/cicd-cloud-run-github-actions

```bash

export PROJECT_ID=project-example
export ACCOUNT_NAME=account-example

gcloud auth login

gcloud projects create $PROJECT_ID
gcloud config set project $PROJECT_ID

open "https://console.cloud.google.com/billing/linkedaccount?project=$PROJECT_ID"

gcloud services enable cloudbuild.googleapis.com run.googleapis.com containerregistry.googleapis.com

gcloud iam service-accounts create $ACCOUNT_NAME \
  --description="Cloud Run deploy account" \
  --display-name="Cloud-Run-Deploy"


gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/run.admin

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/storage.admin

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/iam.serviceAccountUser

gcloud iam service-accounts keys create key.json \
    --iam-account $ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com
```
