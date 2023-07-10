### Create Service Account

```bash
gcloud iam service-accounts create svc-deploy --display-name "svc-deploy"
```

### List Service Accounts

```bash
gcloud iam service-accounts list
```

```bash
export PROJECT_ID=$(gcloud config get-value project)

export SVC_ACCOUNT_NAME=svc-deploy

export SVC_ACCOUNT_EMAIL=$SVC_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com


gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/run.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/storage.admin

# Only if you are pushing images to GCR
```

```bash
gcloud iam service-accounts keys create service-account-key.json --iam-account $SVC_ACCOUNT_EMAIL
```

```bash
# base64 -w 0 service-account-key.json
base64 service-account-key.json | pbcopy
```
